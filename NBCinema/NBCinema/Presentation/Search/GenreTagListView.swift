//
//  GenreTagListView.swift
//  NBCinema
//
//  Created by estelle on 7/20/25.
//

import UIKit
import Then

protocol GenreTagListViewDelegate: AnyObject {
    func didSelectGenre(_ id: Int)
}

class GenreTagListView: UIView {
    
    weak var delegate: GenreTagListViewDelegate?
    private var genreButtonList: [UIButton] = []
    
    func configure(genreList: [Genre]) {
        genreButtonList.forEach { $0.removeFromSuperview() }
        genreButtonList = genreList.map {createTagButton(genre: $0) }
        layoutButtons()
    }
    
    private func createTagButton(genre: Genre) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = genre.name
        config.baseForegroundColor = .label
        config.titleAlignment = .center
        config.baseBackgroundColor = .gray4Dynamic
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var attributes = attributes
            attributes.font = .systemFont(ofSize: 14, weight: .regular)
            return attributes
        }
        
        let button = UIButton(configuration: config).then {
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 17
            $0.clipsToBounds = true
            $0.tag = genre.id
            $0.addTarget(self, action: #selector(genreButtonTapped), for: .touchUpInside)
        }
        
        return button
    }
    
    @objc private func genreButtonTapped(_ sender: UIButton) {
        delegate?.didSelectGenre(sender.tag)
    }
    
    // 버튼을 행 단위로 배치
    private func layoutButtons() {
        var x: CGFloat = 0
        var y: CGFloat = 0
        let spacing: CGFloat = 10
        let maxWidth: CGFloat = self.bounds.width
        
        for button in genreButtonList {
            let size = button.intrinsicContentSize
            if x + size.width + spacing > maxWidth {
                x = 0
                y += size.height + spacing
            }
            button.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
            addSubview(button)
            x += size.width + spacing
        }
    }
    
    // 동적으로 intrinsic height 반환
    override var intrinsicContentSize: CGSize {
        // 레이아웃을 먼저 적용하여 버튼들을 배치
        layoutIfNeeded()
        
        guard genreButtonList.last != nil else {
            return .zero
        }
        
        // 마지막 버튼의 위치 + 높이 + spacing 고려해서 높이 계산
        let bottomY = genreButtonList.map { $0.frame.maxY }.max() ?? 0
        return CGSize(width: UIView.noIntrinsicMetric, height: bottomY)
    }
    
    // 뷰 사이즈 변경 시 레이아웃 다시 계산
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutButtons()
        invalidateIntrinsicContentSize()
    }
    
    // 다크모드 전환 감지
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        genreButtonList.forEach { $0.layer.borderColor = UIColor.borderDynamic.cgColor }
    }
}

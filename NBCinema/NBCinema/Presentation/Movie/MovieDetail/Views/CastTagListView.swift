//
//  CastTagListView.swift
//  NBCinema
//
//  Created by Milou on 7/21/25.
//

import UIKit
import Then

class CastTagListView: UIView {
    
    private var castButtonList: [UIButton] = []
    
    func configure(castList: [String]) {
        castButtonList
            .forEach { $0.removeFromSuperview() }
        
        castButtonList = castList.map { createCastButton(name: $0) }
        layoutButtons()
    }
    
    private func createCastButton(name: String) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = name
        config.baseForegroundColor = .label
        config.baseBackgroundColor = .gray1
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        config.cornerStyle = .capsule
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var attributes = attributes
            attributes.font = .systemFont(ofSize: 14, weight: .regular)
            return attributes
        }
        
        let button = UIButton(configuration: config).then {
            $0.isUserInteractionEnabled = false
        }
        
        return button
    }
    
    // 버튼을 행 단위로 배치
    private func layoutButtons() {
        var x: CGFloat = 0
        var y: CGFloat = 0
        let spacing: CGFloat = 8
        let maxWidth: CGFloat = self.bounds.width
        
        for button in castButtonList {
            let size = button.intrinsicContentSize
            
            // 현재 줄에 공간이 부족하면 다음 줄로
            if x + size.width + spacing > maxWidth {
                x = 0
                y += size.height + spacing
            }
            
            // 버튼 배치
            button.frame = CGRect(x: x, y: y,
                                  width: size.width,
                                  height: size.height)
            addSubview(button)
            
            // 다음 위치 계산
            x += size.width + spacing
        }
    }
    
    // 동적으로 intrinsic height 반환
    override var intrinsicContentSize: CGSize {
        guard !castButtonList.isEmpty else {
            return CGSize(
                width: UIView.noIntrinsicMetric, // auto layout 제약에 따라
                height: 0
            )
        }
        
        // 모든 버튼의 최대 Y 좌표를 찾아서 전체 높이 결정
        let bottomY = castButtonList.map { $0.frame.maxY }.max() ?? 0
        return CGSize(
            width: UIView.noIntrinsicMetric,
            height: bottomY
        )
    }
    
    // 뷰 사이즈 변경 시 레이아웃 다시 계산
    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
}

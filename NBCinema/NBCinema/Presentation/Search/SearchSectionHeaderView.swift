//
//  SearchSectionHeaderView.swift
//  NBCinema
//
//  Created by estelle on 7/21/25.
//

import UIKit
import SnapKit
import Then

class SearchSectionHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "SectionHeaderView"
    
    private let resultTitle = UILabel().then {
        $0.text = "검색 결과"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .reverseSystem
    }
    
    private let resultSubTitle = UILabel().then {
        $0.text = "총 0개의 영화"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .gray3
    }
    
    private lazy var resultStackView = UIStackView(arrangedSubviews: [resultTitle, resultSubTitle]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(resultStackView)
        
        resultStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(title: String) {
        resultSubTitle.text = title
    }
}

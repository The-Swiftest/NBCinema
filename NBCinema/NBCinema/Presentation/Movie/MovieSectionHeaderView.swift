//
//  MovieSectionHeaderView.swift
//  NBCinema
//
//  Created by Milou on 7/18/25.
//

import UIKit
import SnapKit
import Then

class MovieSectionHeaderView: UICollectionReusableView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .label
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func configure(title: String) {
        titleLabel.text = title
    }
}

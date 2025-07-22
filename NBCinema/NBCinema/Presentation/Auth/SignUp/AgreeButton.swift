//
//  agreeButton.swift
//  NBCinema
//
//  Created by estelle on 7/21/25.
//

import UIKit
import SnapKit
import Then

class AgreeButton: UIButton {
    
    private let iconImageView = UIImageView().then {
        $0.tintColor = .gray3
        $0.image = UIImage(systemName: "checkmark.circle")
    }
    
    private let agreeTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .label
        $0.numberOfLines = 0
    }
    
    var didTap: ((Bool) -> Void)?
    private(set) var isChecked = false
    
    init(title: String) {
        super.init(frame: .zero)
        setupUI()
        agreeTitleLabel.text = title
        addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func toggleCheck() {
        isChecked.toggle()
        updateIcon()
        didTap?(isChecked)
    }
    
    func setChecked(_ checked: Bool) {
        isChecked = checked
        updateIcon()
    }
    
    private func updateIcon() {
        let imageName = isChecked ? "checkmark.circle.fill" : "checkmark.circle"
        iconImageView.image = UIImage(systemName: imageName)
        iconImageView.tintColor = isChecked ? .nbcMain: .gray3
    }
    
    private func setupUI() {
        [iconImageView, agreeTitleLabel].forEach { addSubview($0) }
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        agreeTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }
}

//
//  CountView.swift
//  NBCinema
//
//  Created by seongjun cho on 7/19/25.
//

import UIKit

import SnapKit
import Then

final class CountView: UIView {

    // MARK: - UI Components

    private let countLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .black
        $0.text = "0"
    }

    private let plusButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .nbcMain
    }

    private let minusButton = UIButton().then {
        $0.setImage(UIImage(systemName: "minus"), for: .normal)
        $0.tintColor = .nbcMain
    }

    // MARK: - Properties
    var count = 0 {
        didSet {
            countLabel.text = "\(count)"
            onCountChanged?(count)
        }
    }

    var onCountChanged: ((Int) -> Void)?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods

    private func setUI() {
        [minusButton, countLabel, plusButton].forEach {
            addSubview($0)
        }

        minusButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(24)
        }

        countLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        plusButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.width.height.equalTo(24)
        }
    }
    
    private func addTargets() {
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc private func plusButtonTapped() {
        count += 1
        onCountChanged?(count)
    }
    
    @objc private func minusButtonTapped() {
        if count > 0 {
            count -= 1
            onCountChanged?(count)
        }
    }
}

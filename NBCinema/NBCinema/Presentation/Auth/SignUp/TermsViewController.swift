//
//  TermsViewController.swift
//  NBCinema
//
//  Created by estelle on 7/21/25.
//

import UIKit
import Then
import SnapKit

class TermsViewController: UIViewController {
    
    var onAgreeComplete: (() -> Void)?
    
    private let titleLabel = UILabel().then {
        $0.text = "약관에 동의하시면 회원가입이 완료됩니다."
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .left
        $0.textColor = .label
    }
    
    private lazy var allAgreeButton = AgreeButton(title: "전체 동의")
    private lazy var agreementItems: [AgreementItem] = [
        AgreementItem(title: "이용약관 및 개인정보취급방침 (필수)", isRequired: true),
        AgreementItem(title: "개인정보 제3자 제공 동의 (필수)", isRequired: true),
        AgreementItem(title: "마케팅 활용 동의 (선택)", isRequired: false)
    ]
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .fill
        $0.distribution = .equalSpacing
    }
    
    private let confirmButton = NbcButton(title: "동의하고 가입하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        setupSheetStyle()
        setupBinding()
    }
    
    private func setupSheetStyle() {
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        modalPresentationStyle = .pageSheet
    }
    
    private func setupLayout() {
        confirmButton.isEnabled = false
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        [titleLabel, stackView, confirmButton].forEach { view.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        // 전체 및 개별 동의 버튼 추가
        stackView.addArrangedSubview(allAgreeButton)
        agreementItems.forEach {
            stackView.addArrangedSubview($0.button)
        }
    }
    
    private func setupBinding() {
        allAgreeButton.didTap = { [weak self] isChecked in
            self?.agreementItems.forEach { $0.button.setChecked(isChecked) }
            self?.confirmButton.isEnabled = isChecked
        }
        
        agreementItems.forEach { item in
            item.button.didTap = { [weak self] _ in
                guard let self = self else { return }
                
                let allSelected = agreementItems.allSatisfy { $0.button.isChecked }
                allAgreeButton.setChecked(allSelected)
                
                let requiredChecked = agreementItems.filter { $0.isRequired }.allSatisfy { $0.button.isChecked }
                confirmButton.isEnabled = requiredChecked
            }
        }
    }
    
    // 회원가입 동의 시 Alert 표시 후 로그인 화면으로 이동
    @objc private func confirmButtonTapped() {
        let alert = UIAlertController(title: "완료", message: "화원 가입이 완료되었습니다.", preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default) { [weak self] _ in
            self?.dismiss(animated: true) {
                self?.onAgreeComplete?()
            }
        })
        present(alert, animated: true)
    }
}

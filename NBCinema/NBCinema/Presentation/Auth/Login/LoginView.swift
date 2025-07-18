//
//  LoginView.swift
//  NBCinema
//
//  Created by estelle on 7/18/25.
//

import UIKit
import Then
import SnapKit

class LoginView: UIView {
    
    // 배경에 사용될 그라데이션 레이어
    private let gradientLayer = CAGradientLayer().then {
        $0.colors = [
            UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.945, green: 0.831, blue: 0.847, alpha: 1).cgColor
        ]
        $0.locations = [0.0, 1.0]
        $0.startPoint = CGPoint(x: 0.5, y: 0.0)
        $0.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
    // 앱 로고 이미지
    private let logoImageView = UIImageView().then {
        $0.image = .logo
        $0.contentMode = .scaleAspectFit
    }
    
    // 이메일, 비밀번호 입력 필드
    let emailInput = NbcInputField(placeholder: "이메일", type: .email)
    let passwordInput = NbcInputField(placeholder: "비밀번호", type: .password)
    
    // 로그인 버튼
    let loginButton = NbcButton(title: "로그인")
    
    // 계정이 없는지 묻는 문구
    private let questionLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.text = "계정이 없으신가요?"
    }
    
    // 로그인 페이지 이동 버튼
    let moveToSignUpButton = UIButton().then {
        $0.setTitleColor(.nbcMain, for: .normal)
        $0.setTitle("회원가입", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    private let questionStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 구성
    
    private func setupUI() {
        layer.insertSublayer(gradientLayer, at: 0)
        loginButton.isEnabled = false
        
        [questionLabel, moveToSignUpButton].forEach {
            questionStackView.addArrangedSubview($0)
        }
        [logoImageView, emailInput, passwordInput, loginButton, questionStackView].forEach {
            addSubview($0)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(80)
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.width.height.equalTo(200)
        }
        
        emailInput.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(40)
        }
        
        passwordInput.snp.makeConstraints {
            $0.top.equalTo(emailInput.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(40)
        }
        
        loginButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(40)
        }
        
        questionStackView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}



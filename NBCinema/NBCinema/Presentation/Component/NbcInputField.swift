//
//  NbcInputField.swift
//  NBCinema
//
//  Created by estelle on 7/17/25.
//

import UIKit
import SnapKit
import Then

// 입력 필드 타입 정의 (이메일, 비밀번호, 새 비밀번호)
enum FieldType {
    case email
    case password
    case newPassword
}

// 커스텀 입력 필드
final class NbcInputField: UIView {
    
    // 텍스트 필드
    let textField = UITextField().then {
        $0.borderStyle = .none
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.autocapitalizationType = .none
        $0.returnKeyType = .done
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
        $0.leftViewMode = .always
        $0.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
        $0.rightViewMode = .always
    }
    
    // placeholder (커스텀 형태)
    let placeholderLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .gray3
    }
    
    // 에러 라벨
    private let errorLabel = UILabel().then {
        $0.textColor = .systemRed
        $0.textAlignment = .right
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 1
        $0.isHidden = true
    }
    
    // 비밀번호 보기/숨기기 토글 버튼
    private lazy var eyeButton = UIButton().then {
        $0.setImage(UIImage(named: "eyeClose"), for: .normal)
        $0.tintColor = .gray3
        $0.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        $0.isHidden = true
    }
    
    // 텍스트 클리어 버튼
    private lazy var clearButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        $0.tintColor = .gray3
        $0.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        $0.isHidden = true
    }
    
    // 현재 비밀번호 표시 여부 상태
    private var isPasswordVisible = false {
        didSet {
            let icon = isPasswordVisible ? UIImage(systemName: "eye") : UIImage(named: "eyeClose")
            eyeButton.setImage(icon, for: .normal)
            textField.isSecureTextEntry = !isPasswordVisible
        }
    }
    
    // MARK: - 초기화
    
    init(placeholder: String, type: FieldType) {
        super.init(frame: .zero)
        
        // 입력 타입에 따른 설정
        switch type {
        case .email:
            textField.keyboardType = .emailAddress
            textField.textContentType = .emailAddress
            textField.clearButtonMode = .whileEditing
        case .password:
            textField.isSecureTextEntry = true
            textField.textContentType = .password
        case .newPassword:
            textField.isSecureTextEntry = true
            textField.textContentType = .newPassword
        }
        
        // 기본 placeholder 대신 커스텀 라벨로 표시
        placeholderLabel.text = placeholder
        
        // 필드 타입에 따라 오른쪽 버튼 설정
        setupEyeOrClearButton(type)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 구성
    
    private func setupUI() {
        [textField, placeholderLabel, errorLabel].forEach { addSubview($0) }
        
        textField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        placeholderLabel.snp.makeConstraints {
            $0.leading.equalTo(textField).offset(15)
            $0.centerY.equalTo(textField)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // 텍스트필드 오른쪽에 아이콘 버튼 추가 (clear or eye)
    private func setupEyeOrClearButton(_ type: FieldType) {
        let iconSize: CGFloat = 20
        let padding: CGFloat = 12
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize + padding * 2, height: iconSize))
        
        let button = type == .email ? clearButton : eyeButton
        button.frame = CGRect(x: padding, y: 0, width: iconSize, height: iconSize)
        
        containerView.addSubview(button)
        containerView.isUserInteractionEnabled = true
        
        textField.rightView = containerView
        textField.rightViewMode = .always
    }
    
    // MARK: - 액션 메서드
    
    // 비밀번호 보이기/숨기기 토글
    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
    }
    
    // 입력값 초기화
    @objc private func clearTextField() {
        textField.text = ""
    }
    
    // 에러 메시지 메서드
    func setError(_ message: String?) {
        errorLabel.text = message
        errorLabel.isHidden = message == nil
        textField.layer.borderColor = errorLabel.isHidden ? UIColor.white.cgColor : UIColor.nbcMain.cgColor
    }
    
    // 버튼 숨김 여부
    func setHidden(_ hidden: Bool) {
        eyeButton.isHidden = hidden
        clearButton.isHidden = hidden
    }
}

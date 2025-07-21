//
//  SignUpViewModel.swift
//  NBCinema
//
//  Created by estelle on 7/17/25.
//

import Foundation

class SignUpViewModel: ViewModelProtocol {
    enum Action {
        case emailChanged(String)
        case passwordChanged(String)
        case confirmPasswordChanged(String)
        case signUp
    }
    
    struct State {
        var email: String = ""
        var emailError: String?
        
        var password: String = ""
        var passwordError: String?
        
        var confirmPassword: String = ""
        var confirmPasswordError: String?
        
        var isSignUpEnabled: Bool = false       // 회원가입 버튼 활성화 여부
        var isSignedUp: Bool = false            // 키체인 저장 성공 여부
    }
    
    private(set) var state: State = .init() {
        didSet {
            onStateChanged?(state)
        }
    }
    
    var onStateChanged: ((State) -> Void)?
    
    func action(_ action: Action) {
        switch action {
        case .emailChanged(let email):
            state.email = email
            validateEmail()
            
        case .passwordChanged(let password):
            state.password = password
            validatePassword()
            state.confirmPassword = ""
            
        case .confirmPasswordChanged(let confirmPassword):
            state.confirmPassword = confirmPassword
            validateConfirmPassword()
            
        case .signUp:
            state.isSignedUp = KeychainService.save(service: KeychainConstants.service, account: KeychainConstants.emailAccount, value: state.email) && KeychainService.save(service: KeychainConstants.service, account: KeychainConstants.passwordAccount, value: state.password)
        }
        
        updateSignUpEnabled()
    }
    
    // 이메일 유효성 검사
    private func validateEmail() {
        if state.email.isEmpty {
            state.emailError = "이메일을 입력해주세요."
        } else if Validator.isValidEmail(state.email) {
            state.emailError = nil
        } else {
            state.emailError = "올바른 이메일 형식이 아닙니다."
        }
    }
    
    // 비밀번호 유효성 검사
    private func validatePassword() {
        if state.password.isEmpty {
            state.passwordError = "비밀번호를 입력해주세요."
        } else if Validator.isValidPassword(state.password) {
            state.passwordError = nil
        } else {
            state.passwordError = "영문 대소문자/숫자 8자 이상, 특수문자 1개 이상 포함"
        }
    }
    
    // 비밀번호 확인 검사
    private func validateConfirmPassword() {
        if state.confirmPassword.isEmpty {
            state.confirmPasswordError = "비밀번호를 다시 입력해주세요."
        } else if state.password == state.confirmPassword {
            state.confirmPasswordError = nil
        } else {
            state.confirmPasswordError = "비밀번호가 일치하지 않습니다."
        }
    }
    
    // 회원가입 버튼 활성화 여부
    private func updateSignUpEnabled() {
        state.isSignUpEnabled =
        state.emailError == nil &&
        state.passwordError == nil &&
        state.confirmPasswordError == nil &&
        !state.password.isEmpty &&
        !state.confirmPassword.isEmpty &&
        !state.email.isEmpty
    }
}

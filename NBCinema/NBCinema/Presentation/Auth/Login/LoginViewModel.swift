//
//  LoginViewModel.swift
//  NBCinema
//
//  Created by estelle on 7/18/25.
//

import Foundation

class LoginViewModel: ViewModelProtocol {
    enum Action {
        case loadUserData
        case emailChanged(String)
        case passwordChanged(String)
        case login
    }
    
    struct State {
        var email: String = ""
        var emailError: String?
        
        var password: String = ""
        
        var isLoginEnabled: Bool = false       // 로그인 버튼 활성화 여부
        var isLoginSuccess: Bool = false       // 로그인 성공 여부
    }
    
    private(set) var state: State = .init() {
        didSet {
            onStateChanged?(state)
        }
    }
    
    var onStateChanged: ((State) -> Void)?
    private var userEmail = ""
    private var userPassword = ""
    
    func action(_ action: Action) {
        switch action {
        case .loadUserData:
            state.email = KeychainService.load(service: KeychainConstants.service, account: KeychainConstants.emailAccount) ?? ""
            state.password = KeychainService.load(service: KeychainConstants.service, account: KeychainConstants.passwordAccount) ?? ""
            userEmail = state.email
            userPassword = state.password
            
        case .emailChanged(let email):
            state.email = email
            validateEmail()
            
        case .passwordChanged(let password):
            state.password = password
            
        case .login:        // 키체인에 저장된 값과 입력값이 다를 경우 로그인 실패
            state.isLoginSuccess = if (userEmail == state.email && userPassword == state.password) {
                KeychainService.save(
                    service: KeychainConstants.service,
                    account: KeychainConstants.emailAccount,
                    value: state.email
                ) && KeychainService.save(
                    service: KeychainConstants.service,
                    account: KeychainConstants.passwordAccount,
                    value: state.password)
            } else {
                false
            }
            
            if !state.isLoginSuccess {
                state.email = ""
                state.password = ""
            }
        }
        
        updateLoginEnabled()
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
    
    // 로그인 버튼 활성화 여부
    private func updateLoginEnabled() {
        state.isLoginEnabled =
        state.emailError == nil &&
        !state.password.isEmpty &&
        !state.email.isEmpty
    }
}

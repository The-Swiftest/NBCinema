//
//  LoginViewController.swift
//  NBCinema
//
//  Created by estelle on 7/18/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    weak var coordinator: AuthCoordinator?
    private let viewModel: LoginViewModel
    private let loginView = LoginView()
    private var didTapLoginButton = false
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.action(.loadUserData)     // 텍스트필드 자동 입력
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupAction()
        bindViewModel()
    }
    
    override func loadView() {
        view = loginView
    }
    
    // MARK: - Setup 메서드
    
    // 텍스트필드 delegate 연결
    private func setupDelegates() {
        loginView.emailInput.textField.delegate = self
        loginView.passwordInput.textField.delegate = self
    }
    
    // 텍스트필드 및 버튼에 이벤트 연결
    private func setupAction() {
        loginView.emailInput.textField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        loginView.passwordInput.textField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginView.moveToSignUpButton.addTarget(self, action: #selector(moveToSignUpTapped), for: .touchUpInside)
    }
    
    // ViewModel의 상태 바인딩
    private func bindViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            guard let self else { return }
            self.loginView.emailInput.textField.text = state.email
            self.loginView.passwordInput.textField.text = state.password
            self.loginView.emailInput.setHidden(state.email.isEmpty)
            self.loginView.passwordInput.setHidden(state.password.isEmpty)
            self.loginView.emailInput.setError(state.emailError)
            self.loginView.loginButton.isEnabled = state.isLoginEnabled
            
            if self.didTapLoginButton {
                if state.isLoginSuccess {
                    self.coordinator?.loginCompleted()
                } else {
                    self.showAlert()
                }
                self.didTapLoginButton = false
            }
            
            updatePlaceholder(for: loginView.emailInput.textField)
            updatePlaceholder(for: loginView.passwordInput.textField)
        }
    }
    
    // MARK: - Actions
    
    // 이메일 입력 변경 시 호출
    @objc private func emailChanged(_ sender: UITextField) {
        viewModel.action(.emailChanged(sender.text ?? ""))
    }
    
    // 비밀번호 입력 변경 시 호출
    @objc private func passwordChanged(_ sender: UITextField) {
        viewModel.action(.passwordChanged(sender.text ?? ""))
    }
    
    @objc private func loginTapped() {
        didTapLoginButton = true
        viewModel.action(.login)
    }
    
    @objc private func moveToSignUpTapped() {
        coordinator?.showSignUp()
    }
    
    // 로그인 실패 시 Alert
    private func showAlert() {
        let alert = UIAlertController(title: "실패", message: "아이디 또는 비밀번호가 틀립니다.", preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    // 키보드 done 버튼 누를 때 다음 텍스트 필드로 이동
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.emailInput.textField {
            loginView.passwordInput.textField.becomeFirstResponder()
        } else if textField == loginView.passwordInput.textField {
            loginView.passwordInput.textField.resignFirstResponder()
        }
        return true
    }
    
    // 텍스트 필드 포커스 진입 시 placeholder 위로 이동
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updatePlaceholder(for: textField)
    }
    
    // 텍스트 필드 포커스 종료 시 (빈 경우) placeholder 원래 위치로 복귀
    func textFieldDidEndEditing(_ textField: UITextField) {
        updatePlaceholder(for: textField)
    }
    
    // 텍스트필드와 placeholder 쌍을 반환
    private func textFieldPlaceholderPair(for textField: UITextField) -> (UILabel, UITextField)? {
        switch textField {
        case loginView.emailInput.textField:
            return (loginView.emailInput.placeholderLabel, loginView.emailInput.textField)
        case loginView.passwordInput.textField:
            return (loginView.passwordInput.placeholderLabel, loginView.passwordInput.textField)
        default:
            return nil
        }
    }
    
    private func updatePlaceholder(for textField: UITextField) {
        guard let (placeholder, input) = textFieldPlaceholderPair(for: textField) else { return }
        
        let isEmpty = textField.text?.isEmpty ?? true
        let shouldMoveUp = textField.isFirstResponder || !isEmpty
        
        UIView.animate(withDuration: 0.25) {
            placeholder.snp.updateConstraints {
                $0.centerY.equalTo(input).offset(shouldMoveUp ? -15 : 0)
            }
            placeholder.font = .systemFont(ofSize: shouldMoveUp ? 12 : 16)
            placeholder.superview?.layoutIfNeeded()
        }
    }
}

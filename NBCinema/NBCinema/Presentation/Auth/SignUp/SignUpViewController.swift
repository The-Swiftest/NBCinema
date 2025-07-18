//
//  SignUpViewController.swift
//  NBCinema
//
//  Created by estelle on 7/17/25.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    weak var coordinator: AuthCoordinator?
    private let viewModel: SignUpViewModel
    private let signUpView = SignUpView()
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupAction()
        bindViewModel()
    }
    
    // MARK: - Setup 메서드
    
    // 텍스트필드 delegate 연결
    private func setupDelegates() {
        signUpView.emailInput.textField.delegate = self
        signUpView.passwordInput.textField.delegate = self
        signUpView.confirmPasswordInput.textField.delegate = self
    }
    
    // 텍스트필드 및 버튼에 이벤트 연결
    private func setupAction() {
        signUpView.emailInput.textField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        signUpView.passwordInput.textField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        signUpView.confirmPasswordInput.textField.addTarget(self, action: #selector(confirmPasswordChanged), for: .editingChanged)
        signUpView.signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        signUpView.moveToLoginButton.addTarget(self, action: #selector(moveToLoginTapped), for: .touchUpInside)
    }
    
    // ViewModel의 상태 바인딩
    private func bindViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            if state.isSignedUp {
                self?.showAlert()
            }
            
            self?.signUpView.emailInput.setError(state.emailError)
            self?.signUpView.passwordInput.setError(state.passwordError)
            self?.signUpView.confirmPasswordInput.setError(state.confirmPasswordError)
            self?.signUpView.confirmPasswordInput.textField.text = state.confirmPassword
            self?.signUpView.signUpButton.isEnabled = state.isSignUpEnabled
        }
    }
    
    // MARK: - Actions
    
    // 이메일 입력 변경 시 호출
    @objc private func emailChanged(_ sender: UITextField) {
        viewModel.action(.emailChanged(sender.text ?? ""))
        signUpView.emailInput.setHidden(sender.text?.isEmpty ?? true)
    }
    
    // 비밀번호 입력 변경 시 호출
    @objc private func passwordChanged(_ sender: UITextField) {
        viewModel.action(.passwordChanged(sender.text ?? ""))
        signUpView.passwordInput.setHidden(sender.text?.isEmpty ?? true)
    }
    
    // 비밀번호 확인 입력 변경 시 호출
    @objc private func confirmPasswordChanged(_ sender: UITextField) {
        viewModel.action(.confirmPasswordChanged(sender.text ?? ""))
        signUpView.confirmPasswordInput.setHidden(sender.text?.isEmpty ?? true)
    }
    
    // 회원가입 버튼 클릭 시 호출
    @objc private func signUpTapped() {
        viewModel.action(.signUp)
    }
    
    // 회원가입 완료 시 Alert 표시 후 로그인 화면으로 이동
    private func showAlert() {
        let alert = UIAlertController(title: "완료", message: "화원 가입이 완료되었습니다.", preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default) { [weak self] _ in
            self?.moveToLoginTapped()
        })
        present(alert, animated: true)
    }
    
    // 로그인 화면으로 이동
    @objc private func moveToLoginTapped() {
        coordinator?.backToLogin()
    }
}

// MARK: - UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    
    // 텍스트 필드 포커스 진입 시 placeholder 위로 이동
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.25) {
            guard let (placeholder, input) = self.textFieldPlaceholderPair(for: textField) else { return }
            placeholder.snp.updateConstraints {
                $0.centerY.equalTo(input).offset(-15)
            }
            placeholder.font = .systemFont(ofSize: 12)
            placeholder.superview?.layoutIfNeeded()
        }
    }
    
    // 텍스트 필드 포커스 종료 시 (빈 경우) placeholder 원래 위치로 복귀
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField.text?.isEmpty ?? true else { return }
        
        UIView.animate(withDuration: 0.25) {
            guard let (placeholder, input) = self.textFieldPlaceholderPair(for: textField) else { return }
            placeholder.snp.updateConstraints {
                $0.centerY.equalTo(input)
            }
            placeholder.font = .systemFont(ofSize: 16)
            placeholder.superview?.layoutIfNeeded()
        }
    }
    
    // 텍스트필드와 placeholder 쌍을 반환
    private func textFieldPlaceholderPair(for textField: UITextField) -> (UILabel, UITextField)? {
        switch textField {
        case signUpView.emailInput.textField:
            return (signUpView.emailInput.placeholderLabel, signUpView.emailInput.textField)
        case signUpView.passwordInput.textField:
            return (signUpView.passwordInput.placeholderLabel, signUpView.passwordInput.textField)
        case signUpView.confirmPasswordInput.textField:
            return (signUpView.confirmPasswordInput.placeholderLabel, signUpView.confirmPasswordInput.textField)
        default:
            return nil
        }
    }
}

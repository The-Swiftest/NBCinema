//
//  LoginViewController.swift
//  NBCinema
//
//  Created by estelle on 7/18/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    weak var coordinator: AuthCoordinator?
    private let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAction()
    }
    
    override func loadView() {
        view = loginView
    }
    
    // 버튼에 이벤트 연결
    private func setupAction() {
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginView.moveToSignUpButton.addTarget(self, action: #selector(moveToSignUpTapped), for: .touchUpInside)
    }
    
    @objc private func loginTapped() {
        coordinator?.loginCompleted()
    }
    
    @objc private func moveToSignUpTapped() {
        coordinator?.showSignUp()
    }
}

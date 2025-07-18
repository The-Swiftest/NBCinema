//
//  AuthCoordinator.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func didFinishLogin(_ coordinator: AuthCoordinator)
}

/// 로그인/회원가입 흐름을 관리하는 Coordinator
class AuthCoordinator: BaseCoordinator {
    weak var delegate: AuthCoordinatorDelegate?
    
    override func start() {
        showLogin()
    }
    
    /// 로그인 화면 표시
    private func showLogin() {
        let authVC = LoginViewController()
        authVC.coordinator = self
        navigationController.setViewControllers([authVC], animated: false)
    }
    
    func loginCompleted() {
        delegate?.didFinishLogin(self)
    }
    
    /// 회원가입 화면 표시
    func showSignUp() {
        let signUpVC = SignUpViewController(viewModel: SignUpViewModel())
        signUpVC.coordinator = self
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    func backToLogin() {
        navigationController.popViewController(animated: true)
    }
}

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
        // TODO: LoginViewController 구현 후 연결
        let authVC = UIViewController() // 임시 ViewController
        authVC.view.backgroundColor = .systemBlue
        authVC.title = "로그인 화면"
        
        setupLoginButtons(in: authVC)
        
        navigationController.setViewControllers([authVC], animated: false)
    }
    
    private func setupLoginButtons(in viewController: UIViewController) {
        // 로그인 완료 버튼
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("로그인 완료 후 메인탭바", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemGreen
        loginButton.layer.cornerRadius = 8
        loginButton.addTarget(self, action: #selector(loginCompleted), for: .touchUpInside)
        
        // 회원가입 버튼
        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = .systemOrange
        signUpButton.layer.cornerRadius = 8
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        // 안내 라벨
        let label = UILabel()
        label.text = "로그인 화면"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        viewController.view.addSubview(label)
        viewController.view.addSubview(loginButton)
        viewController.view.addSubview(signUpButton)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // 라벨
            label.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor, constant: -60),
            
            // 로그인 버튼
            loginButton.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // 회원가입 버튼
            signUpButton.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signUpButton.widthAnchor.constraint(equalToConstant: 150),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func signUpTapped() {
        showSignUp()
    }
    
    @objc private func loginCompleted() {
        delegate?.didFinishLogin(self)
    }
    
    /// 회원가입 화면 표시
    func showSignUp() {
        let signUpVC = UIViewController()
        signUpVC.view.backgroundColor = .systemGreen
        signUpVC.title = "회원가입"
        
        signUpVC.navigationItem.hidesBackButton = true
        
        // 뒤로가기 버튼
        let backButton = UIButton(type: .system)
        backButton.setTitle("회원가입완료(로그인으로)", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.backgroundColor = .systemBlue
        backButton.layer.cornerRadius = 8
        backButton.addTarget(self, action: #selector(backToLogin), for: .touchUpInside)
        
        
        
        signUpVC.view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: signUpVC.view.centerXAnchor),
            backButton.topAnchor.constraint(equalTo: signUpVC.view.safeAreaLayoutGuide.topAnchor, constant: 120),
            backButton.widthAnchor.constraint(equalToConstant: 200),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    @objc private func backToLogin() {
        navigationController.popViewController(animated: true)
    }
}

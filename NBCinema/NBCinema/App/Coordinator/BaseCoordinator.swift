//
//  BaseCoordinator.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import UIKit

/// 모든 Coordinator가 따라야 하는 기본 프로토콜
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func finish()
}

/// Coordinator의 공통 기능을 구현한 기본 클래스
class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // 하위클래스들에서 구현
    }
    
    func finish() {
        // 자식 Coordinator들 정리
        return childCoordinators.removeAll()
    }
    
    /// 자식 Coordinator 추가
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    /// 자식 Coordinator 제거
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    /// 공통 Error Alert
    func showErrorAlert(title: String = "오류", message: String, completion: (() -> Void)? = nil) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
                completion?()
            })
            
            DispatchQueue.main.async { [weak self] in
                self?.navigationController.present(alert, animated: true)
            }
        }

    func showAnyAlert(_ alert: UIAlertController) {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.present(alert, animated: true)
        }
    }
}

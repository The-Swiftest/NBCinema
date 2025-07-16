//
//  AppCoordinator.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import UIKit

/// 앱 전체의 흐름을 관리하는 최상위 Coordinator
class AppCoordinator: BaseCoordinator {
    override func start() {
        // TODO: 로그인 상태 확인 후 분기 처리
        // 현재는 바로 로그인 화면으로 이동
        showAuth()
    }
    
    /// 로그인/회원가입 화면으로 이동
    private func showAuth() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.delegate = self
        addChildCoordinator(authCoordinator)
        authCoordinator.start()
    }
    
    /// 메인 TabBar 화면으로 이동
    private func showMainTab() {
        let mainTabCoordinator = MainTabCoordinator(navigationController: navigationController)
        mainTabCoordinator.delegate = self
        addChildCoordinator(mainTabCoordinator)
        mainTabCoordinator.start()
    }
}

extension AppCoordinator: AuthCoordinatorDelegate {
    func didFinishLogin(_ coordinator: AuthCoordinator) {
        removeChildCoordinator(coordinator)  // Auth coordinator 제거
        showMainTab()  // MainTab으로 전환
    }
}

extension AppCoordinator: MainTabCoordinatorDelegate {
    func didLogout(_ coordinator: MainTabCoordinator) {
        removeChildCoordinator(coordinator)
        showAuth() // 로그인 화면으로 돌아가기
    }
}

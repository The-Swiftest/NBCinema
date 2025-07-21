//
//  MyPageCoordinator.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import UIKit

protocol MyPageCoordinatorDelegate: AnyObject {
    func myPageCoordinatorDidLogout(_ coordinator: MyPageCoordinator)
}

/// 마이페이지 화면들을 관리하는 Coordinator
class MyPageCoordinator: BaseCoordinator {
    weak var delegate: MyPageCoordinatorDelegate?
    
    override func start() {
        showMyPage()
    }
    
    /// 마이페이지 화면 표시
    private func showMyPage() {
		let myPageVC = MyPageViewController()
        myPageVC.coordinator = self
        navigationController.setViewControllers([myPageVC], animated: false)
    }
    
    /// 예매 내역 화면으로 이동
    func showBookingHistory(reservationData: [ReservationDetail]) {
        let bookingHistoryVC = ReserveListViewController(reservationData: reservationData)
        bookingHistoryVC.coordinator = self
        navigationController.pushViewController(bookingHistoryVC, animated: true)
    }
    
    /// 찜한 영화 목록 화면으로 이동
    func showFavoriteMovies(favoriteData: [FavoriteMovie]) {
        let favoriteVC = FavoriteListViewController(favoriteData: favoriteData)
        favoriteVC.coordinator = self
        navigationController.pushViewController(favoriteVC, animated: true)
    }

    /// 오류 알림창 출력
    func showErrorAlert(alert: UIAlertController) {
        navigationController.pushViewController(alert, animated: false)
    }
}

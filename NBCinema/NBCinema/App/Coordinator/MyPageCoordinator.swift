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
        // TODO: MyPageViewController 구현 후 연결
		let myPageVC = MyPageViewController()

        myPageVC.myPageView.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        navigationController.setViewControllers([myPageVC], animated: false)
    }
    
    @objc private func logoutTapped() {
        delegate?.myPageCoordinatorDidLogout(self)
    }
    
    /// 예매 내역 화면으로 이동
    func showBookingHistory() {
        // TODO: BookingHistoryViewController 구현 후 연결
        let bookingHistoryVC = UIViewController() // 임시 ViewController
        bookingHistoryVC.view.backgroundColor = .systemIndigo
        bookingHistoryVC.title = "예매 내역"
        
        navigationController.pushViewController(bookingHistoryVC, animated: true)
    }
    
    /// 찜한 영화 목록 화면으로 이동
    func showFavoriteMovies() {
        // TODO: FavoriteMoviesViewController 구현 후 연결
        let favoriteVC = UIViewController() // 임시 ViewController
        favoriteVC.view.backgroundColor = .systemPink
        favoriteVC.title = "찜한 영화"
        
        navigationController.pushViewController(favoriteVC, animated: true)
    }
}

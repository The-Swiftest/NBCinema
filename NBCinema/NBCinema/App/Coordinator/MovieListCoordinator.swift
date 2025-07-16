//
//  MovieListCoordinator.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import UIKit

/// 영화목록 화면들을 관리하는 Coordinator
class MovieListCoordinator: BaseCoordinator {
    override func start() {
        showMovieList()
    }
    
    /// 영화목록 화면 표시
    private func showMovieList() {
        // TODO: MovieListViewController 구현 후 연결
        let movieListVC = UIViewController()
        movieListVC.view.backgroundColor = .systemOrange
        movieListVC.title = "영화목록"
        
        navigationController.setViewControllers([movieListVC], animated: false)
    }
    
    // 영화 상세 화면으로 이동 (나중에 구현)
    func showMovieDetail(movieId: Int) {
        let movieDetailVC = UIViewController()
        movieDetailVC.view.backgroundColor = .systemPurple
        movieDetailVC.title = "영화 상세"
        
        navigationController.pushViewController(movieDetailVC, animated: true)
    }
    
    /// 영화 예매 화면으로 이동
    func showBooking(movieId: Int) {
        // TODO: 예매 Coordinator 구현 후 연결
        print("영화 예매 화면 이동: \(movieId)")
    }
}

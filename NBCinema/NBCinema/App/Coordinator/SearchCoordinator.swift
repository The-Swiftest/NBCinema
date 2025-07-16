//
//  SearchCoordinator.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import UIKit

/// 검색 화면들을 관리하는 Coordinator
class SearchCoordinator: BaseCoordinator {
    
    override func start() {
        showSearch()
    }
    
    /// 검색 화면 표시
    private func showSearch() {
        // TODO: SearchViewController 구현 후 연결
        let searchVC = UIViewController() // 임시 ViewController
        searchVC.view.backgroundColor = .systemYellow
        searchVC.title = "검색"
        
        navigationController.setViewControllers([searchVC], animated: false)
    }
    
    /// 검색된 영화 상세 화면으로 이동
    func showMovieDetail(movieId: Int) {
        // TODO: MovieListViewController 구현 후 연결
        let movieDetailVC = UIViewController()
        movieDetailVC.view.backgroundColor = .systemPurple
        movieDetailVC.title = "영화 상세 (검색에서)"
        
        navigationController.pushViewController(movieDetailVC, animated: true)
    }
}

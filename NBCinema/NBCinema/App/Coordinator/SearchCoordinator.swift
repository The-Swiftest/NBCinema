//
//  SearchCoordinator.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import UIKit

/// 검색 화면들을 관리하는 Coordinator
class SearchCoordinator: BaseCoordinator {
    
    private let movieRepository: MovieRepository
    
    init(navigationController: UINavigationController, movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        showSearch()
    }
    
    /// 검색 화면 표시
    private func showSearch() {
        let searchVC = SearchViewController(repository: movieRepository)
        searchVC.coordinator = self
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

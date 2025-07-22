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
        let movieDetailCoordinator = MovieDetailCoordinator(
            navigationController: navigationController,
            movieRepository: movieRepository,
            movieId: movieId,
            parentCoordinator: self
        )
        
        // 자식 coordinator로 추가
        addChildCoordinator(movieDetailCoordinator)
        
        // coordinator 시작
        movieDetailCoordinator.start()
    }
}

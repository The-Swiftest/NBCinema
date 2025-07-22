//
//  MovieListCoordinator.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import UIKit

/// 영화목록 화면들을 관리하는 Coordinator
class MovieListCoordinator: BaseCoordinator {
    
    private let movieRepository: MovieRepository
    
    init(navigationController: UINavigationController, movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        showMovieList()
    }
    
    /// 영화목록 화면 표시
    private func showMovieList() {
        let viewModel = MovieListViewModel(repository: movieRepository)
        let movieListVC = MovieListViewController(viewModel: viewModel, coordinator: self)
        navigationController.setViewControllers([movieListVC], animated: false)
    }
    
    func showError(_ error: Error) {
            showErrorAlert(title: "영화 로드 실패", message: error.localizedDescription)
        }
    
    /// 영화 상세 화면으로 이동
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

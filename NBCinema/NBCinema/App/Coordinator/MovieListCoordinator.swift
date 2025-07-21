//
//  MovieListCoordinator.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import UIKit

/// 영화목록 화면들을 관리하는 Coordinator
class MovieListCoordinator: BaseCoordinator {
    // MARK: - 테스트용 프로퍼티
    private var testGenres: [Genre]?
    private var testMovieId: Int?
    
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
    
    // 영화 상세 화면으로 이동 (나중에 구현)
    func showMovieDetail(movieId: Int) {
        let movieDetailVC = UIViewController()
        movieDetailVC.view.backgroundColor = .systemPurple
        movieDetailVC.title = "영화 상세"
        print("영화 예매 화면 이동: \(movieId)")
        navigationController.pushViewController(movieDetailVC, animated: true)
    }
}

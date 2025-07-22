//
//  MovieDetailCoordinator.swift
//  NBCinema
//
//  Created by Milou on 7/21/25.
//

import UIKit

class MovieDetailCoordinator: BaseCoordinator {
    private let movieRepository: MovieRepository
    private let movieId: Int
    private weak var parentCoordinator: MovieListCoordinator?
    
    init(navigationController: UINavigationController,
         movieRepository: MovieRepository,
         movieId: Int,
         parentCoordinator: MovieListCoordinator? = nil) {
        self.movieRepository = movieRepository
        self.movieId = movieId
        self.parentCoordinator = parentCoordinator
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        showMovieDetail()
    }
    
    private func showMovieDetail() {
           let viewModel = MovieDetailViewModel(repository: movieRepository)
           let movieDetailVC = MovieDetailViewController(viewModel: viewModel, coordinator: self)
            movieDetailVC.loadMovieDetail(movieId: movieId)
           navigationController.pushViewController(movieDetailVC, animated: true)
       }
       
       func showError(_ error: Error) {
           showErrorAlert(message: error.localizedDescription)
       }
    
    func showReservation(movieId: Int) {
        let reserveVC = ReserveViewController(id: movieId)
        reserveVC.coordinator = self
        navigationController.pushViewController(reserveVC, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
        finish()
    }
    
    override func finish() {
        super.finish()
        // 부모 coordinator에서 자신을 제거
        parentCoordinator?.removeChildCoordinator(self)
    }
}

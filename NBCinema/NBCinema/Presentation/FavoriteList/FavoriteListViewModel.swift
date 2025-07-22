
//
//  FavoriteListViewModel.swift
//  NBCinema
//
//  Created by seongjun cho on 7/21/25.
//

import Foundation

final class FavoriteListViewModel: ViewModelProtocol {

    // MARK: - State
    struct State {
        var favoriteMovies: [FavoriteMovie]
    }

    private(set) var state: State
    var onStateChange: ((State) -> Void)?

    // MARK: - Properties
    private let userActivityService = UserActivityService()
    var onError: ((Error) -> Void)?

    // MARK: - Initializers
    init(favoriteMovies: [FavoriteMovie]) {
        self.state = State(favoriteMovies: favoriteMovies)
    }

    // MARK: - Input/Action
    enum Action {
        case deleteFavorite(movieTitle: String)
    }

    func action(_ action: Action) {
        switch action {
        case .deleteFavorite(let movieTitle):
            deleteFavorite(movieTitle: movieTitle)
        }
    }

    // MARK: - Methods
    private func deleteFavorite(movieTitle: String) {
        do {
            try userActivityService.deleteFavorite(movieTitle: movieTitle)
            let updatedFavorites = try userActivityService.readFavorites()
            state.favoriteMovies = updatedFavorites
            onStateChange?(state)
        } catch {
            onError?(error)
        }
    }
}

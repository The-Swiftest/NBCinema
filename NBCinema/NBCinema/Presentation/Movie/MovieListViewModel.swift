//
//  MovieListViewModel.swift
//  NBCinema
//
//  Created by Milou on 7/20/25.
//

import Foundation

enum MovieListAction {
    case fetchMovies
}

struct MovieListState {
    var nowPlayingMovies: [Movie] = []
    var popularMovies: [Movie] = []
    var upcomingMovies: [Movie] = []
    var topRatedMovies: [Movie] = []
    var error: Error?
}

class MovieListViewModel: ViewModelProtocol {
    
    typealias Action = MovieListAction
    typealias State = MovieListState
    
    private(set) var state: MovieListState = .init() {
        didSet {
            onStateChanged?(state)
        }
    }
    
    var onStateChanged: ((State) -> Void)?
    
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func action(_ action: MovieListAction) {
        switch action {
        case .fetchMovies:
            fetchMovies()
        }
    }
    
    private func fetchMovies() {
        Task {
            do {
                async let nowPlaying = repository.fetchNowPlayingMovies()
                async let popular = repository.fetchPopularMovies()
                async let upcoming = repository.fetchUpcomingMovies()
                async let topRated = repository.fetchTopRatedMovies()
                
                let (nowPlayingMovies,
                     popularMovies,
                     upcomingMovies,
                     topRatedMovies) = try await (nowPlaying,
                                                  popular,
                                                  upcoming,
                                                  topRated)
                
                await MainActor.run {
                    state.nowPlayingMovies = nowPlayingMovies
                    state.popularMovies = popularMovies
                    state.upcomingMovies = upcomingMovies
                    state.topRatedMovies = topRatedMovies
                }
                
            } catch {
                await MainActor.run {
                    state.error = error
                }
            }
        }
    }
}

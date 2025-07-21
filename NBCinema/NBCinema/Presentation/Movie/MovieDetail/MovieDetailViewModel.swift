//
//  MovieDetailViewModel.swift
//  NBCinema
//
//  Created by Milou on 7/21/25.
//

import Foundation

enum MovieDetailAction {
    case viewDidLoad(movieId: Int)
    case favoriteButtonTapped
}

struct MovieDetailState {
    var movieDetail: MovieDetail?
    var director: String?
    var cast: [String] = []
    var isFavorite: Bool = false
    var error: Error?
}

final class MovieDetailViewModel: ViewModelProtocol {
    
    typealias Action = MovieDetailAction
    typealias State = MovieDetailState
    
    private(set) var state: MovieDetailState = .init() {
        didSet {
            onStateChanged?(state)
        }
    }
    
    var onStateChanged: ((State) -> Void)?
    
    private let repository: MovieRepository
    private let userActivityService = UserActivityService()
    private var currentMovieId: Int?
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func action(_ action: MovieDetailAction) {
        switch action {
        case .viewDidLoad(let movieId):
            currentMovieId = movieId
            fetchMovieDetail(movieId: movieId)
            
        case .favoriteButtonTapped:
            toggleFavorite()
        }
    }
    
    /// 현재 영화 ID 반환 (ViewController에서 예매 화면 이동 시 사용)
    var currentMovieIdForReservation: Int? {
        return currentMovieId
    }
    
    private func fetchMovieDetail(movieId: Int) {
        state.error = nil
        
        Task {
            do {
                async let movieDetail = repository.fetchMovieDetail(id: movieId)
                async let credit = repository.fetchMovieCredits(id: movieId)
                
                let (movieDetails, credits) = try await (movieDetail, credit)
                
                await MainActor.run {
                    state.movieDetail = movieDetails
                    state.director = credits.director
                    state.cast = credits.cast
                    
                    // 영화 정보가 로드된 후 찜 상태 확인
                    checkFavoriteStatus()
                }
            } catch {
                await MainActor.run {
                    state.error = error
                }
            }
        }
    }
    
    private func checkFavoriteStatus() {
        guard let movieDetail = state.movieDetail else { return }
        
        do {
            let favorites = try userActivityService.readFavorites()
            state.isFavorite = favorites.contains { favorite in
                return favorite.movieTitle == movieDetail.title
            }
        } catch {
            print("찜 상태 확인 실패: \(error)")
        }
    }
    
    private func toggleFavorite() {
        guard let movieDetail = state.movieDetail else { return }
        
        do {
            if state.isFavorite {
                // 찜 해제
                try userActivityService.deleteFavorite(movieTitle: movieDetail.title)
                state.isFavorite = false
                print("🔖 찜 해제됨: \(movieDetail.title)")
            } else {
                // 찜하기
                let favoriteMovie = FavoriteMovie(
                    movieTitle: movieDetail.title,
                    runtime: movieDetail.runtime,
                    genres: movieDetail.genres
                )
                try userActivityService.saveFavorite(data: favoriteMovie)
                state.isFavorite = true
                print("🔖 찜하기 완료: \(movieDetail.title)")
            }
        } catch {
            print("찜하기 처리 실패: \(error)")
            state.error = error
        }
    }
}

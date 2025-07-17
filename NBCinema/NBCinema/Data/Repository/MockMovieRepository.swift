//
//  MockMovieRepository.swift
//  NBCinema
//
//  Created by Milou on 7/17/25.
//

import Foundation

final class MockMovieRepository: MovieRepository {
    func fetchNowPlayingMovies() async throws -> [Movie] {
        return MockData.nowPlayingMovies
    }

    func fetchPopularMovies() async throws -> [Movie] {
        return MockData.popularMovies
    }

    func fetchUpcomingMovies() async throws -> [Movie] {
        return MockData.upcomingMovies
    }

    func fetchTopRatedMovies() async throws -> [Movie] {
        return MockData.topRatedMovies
    }

    func fetchMovieDetail(id: Int) async throws -> MovieDetail {
        if let movieDetail = MockData.movieDetails.first(where: { $0.id == id }) {
            return movieDetail
        }
        
        // 없으면 첫 번째 영화 반환 (테스트용)
        return MockData.movieDetails[0]
    }

    func searchMovies(query: String) async throws -> [Movie] {
        guard !query.isEmpty else {
            return MockData.allMovies
        }
        
        let filteredMovies = MockData.allMovies.filter { movie in
            movie.title.localizedCaseInsensitiveContains(query)
        }
        
        return filteredMovies
    }

    func fetchGenres() async throws -> [Genre] {
        return MockData.genres
    }

    func fetchMoviesByGenre(genreId: Int) async throws -> [Movie] {
        let filteredMovies = MockData.getMoviesByGenre(genreId: genreId)
        return filteredMovies
    }

    func fetchMovieCredits(id: Int) async throws -> (director: String?, cast: [String]) {
        let credits = MockData.movieCredits[id] ?? MockData.defaultCredits
        return credits
    }
}

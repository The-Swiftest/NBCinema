//
//  NetworkMovieRepository.swift
//  NBCinema
//
//  Created by Milou on 7/17/25.
//

import Foundation

final class NetworkMovieRepository: MovieRepository {
    
    private let client = NetworkClient.shared
    
    // MARK: - 영화 목록 조회
    
    func fetchNowPlayingMovies() async throws -> [Movie] {
        let endpoint = TMDBEndPoint.nowPlaying
        let response: MovieListResponse = try await client.request(url: endpoint.url)
        return response.results
    }
    
    func fetchPopularMovies() async throws -> [Movie] {
        let endpoint = TMDBEndPoint.popular
        let response: MovieListResponse = try await client.request(url: endpoint.url)
        return response.results
    }
    
    func fetchUpcomingMovies() async throws -> [Movie] {
        let endpoint = TMDBEndPoint.upcoming
        let response: MovieListResponse = try await client.request(url: endpoint.url)
        return response.results
    }
    
    func fetchTopRatedMovies() async throws -> [Movie] {
        let endpoint = TMDBEndPoint.topRated
        let response: MovieListResponse = try await client.request(url: endpoint.url)
        return response.results
    }
    
    // MARK: - 영화 상세 정보
    
    func fetchMovieDetail(id: Int) async throws -> MovieDetail {
        let endpoint = TMDBEndPoint.movieDetail(id)
        let movieDetail: MovieDetail = try await client.request(url: endpoint.url)
        return movieDetail
    }
    
    func fetchMovieCredits(id: Int) async throws -> (director: String?, cast: [String]) {
        let endpoint = TMDBEndPoint.movieCredits(id: id)
        let response: MovieCreditsResponse = try await client.request(url: endpoint.url)
        return response.credits
    }
    
    // MARK: - 검색
    
    func searchMovies(query: String) async throws -> [Movie] {
        let endpoint = TMDBEndPoint.search(query: query)
        let response: MovieListResponse = try await client.request(url: endpoint.url)
        return response.results
    }
    
    func fetchGenres() async throws -> [Genre] {
        let endpoint = TMDBEndPoint.genres
        let response: GenreListResponse = try await client.request(url: endpoint.url)
        return response.genres
    }
    
    func fetchMoviesByGenre(genreId: Int) async throws -> [Movie] {
        let endpoint = TMDBEndPoint.moviesByGenre(genreId: genreId)
        let response: MovieListResponse = try await client.request(url: endpoint.url)
        return response.results
    }
}

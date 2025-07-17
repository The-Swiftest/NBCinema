//
//  MovieRepository.swift
//  NBCinema
//
//  Created by Milou on 7/17/25.
//

import Foundation

protocol MovieRepository {
    /// 현재 상영중 영화 목록 조회
    func fetchNowPlayingMovies() async throws -> [Movie]
    
    /// 인기 영화 목록 조회
    func fetchPopularMovies() async throws -> [Movie]
    
    /// 개봉 예정 영화 목록 조회
    func fetchUpcomingMovies() async throws -> [Movie]
    
    /// 높은 평점 영화 목록 조회
    func fetchTopRatedMovies() async throws -> [Movie]
    
    /// 영화 상세 정보 조회
    func fetchMovieDetail(id: Int) async throws -> MovieDetail
    
    /// 영화 크레딧 정보 조회 (감독, 출연진)
    func fetchMovieCredits(id: Int) async throws -> (director: String?, cast: [String])
    
    /// 영화 검색
    func searchMovies(query: String) async throws -> [Movie]
    
    /// 장르 목록 조회
    func fetchGenres() async throws -> [Genre]
    
    /// 장르별 영화 필터링
    func fetchMoviesByGenre(genreId: Int) async throws -> [Movie]
}

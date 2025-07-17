//
//  MovieRepository.swift
//  NBCinema
//
//  Created by Milou on 7/17/25.
//

import Foundation

protocol MovieRepository {
    /// 현재 상영중 영화 목록 조회
    func fetchNowPlayingMovies() async -> Result<[Movie], Error>
    
    /// 인기 영화 목록 조회
    func fetchPopularMovies() async -> Result<[Movie], Error>
    
    /// 개봉 예정 영화 목록 조회
    func fetchUpcomingMovies() async -> Result<[Movie], Error>
    
    /// 높은 평점 영화 목록 조회
    func fetchTopRatedMovies() async -> Result<[Movie], Error>
    
    /// 영화 상세 정보 조회
    func fetchMovieDetail(id: Int) async -> Result<MovieDetail, Error>
    
    /// 영화 검색
    func searchMovies(query: String) async -> Result<[Movie], Error>
    
    /// 장르 목록 조회
    func fetchGenres() async -> Result<[Genre], Error>
    
    /// 영화 크레딧 정보 조회 (감독, 출연진)
    func fetchMovieCredits(id: Int) async -> Result<(director: String?, cast: [String]), Error>
}

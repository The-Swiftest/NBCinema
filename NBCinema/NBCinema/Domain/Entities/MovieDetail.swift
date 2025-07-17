//
//  MovieDetail.swift
//  NBCinema
//
//  Created by Milou on 7/17/25.
//

import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
}

/// 영화 상세 정보 (상세 화면 및 예매 화면용)
struct MovieDetail {
    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let popularity: Double
    let voteAverage: Double
    let runtime: Int
    let overview: String
    let genres: [Genre]
}

extension MovieDetail: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, title, popularity, runtime, overview, genres
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}

extension MovieDetail {
    /// 포스터 이미지 URL 반환 (Kingfisher용)
    @inlinable
    var posterURL: URL? {
        posterPath
            .flatMap { URL(string: "\(Config.tmdbImageBaseURL)/w500\($0)") }
    }
    /// 배경 이미지 URL 반환 (Kingfisher용)
    @inlinable
    var backdropURL: URL? {
        backdropPath
            .flatMap { URL(string: "\(Config.tmdbImageBaseURL)/w780\($0)") }
    }
    
    /// 예매율 (popularity를 백분율로 변환)
    @inlinable
    var bookingRate: Double {
        min(popularity / 100.0, 100.0)
    }
    
    /// 러닝타임 포맷팅
    @inlinable
    var runtimeString: String {
        runtime > 0 ? runtime.toTimeString() : "정보 없음"
    }
    
    /// 장르 문자열
    @inlinable
    var genreNames: String {
        genres
            .map { $0.name }.joined(separator: ", ")
    }
    
    /// 개봉일 포맷팅
    @inlinable
    var releaseDateFormatted: String {
        releaseDate.toDotDateString()
    }
}

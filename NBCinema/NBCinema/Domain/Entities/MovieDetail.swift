//
//  MovieDetail.swift
//  NBCinema
//
//  Created by Milou on 7/17/25.
//

import Foundation

struct Genre {
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

extension MovieDetail {
    /// 포스터 이미지 URL 반환 (Kingfisher용)
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "\(Config.tmdbImageBaseURL)/w500\(posterPath)")
    }
    /// 배경 이미지 URL 반환 (Kingfisher용)
    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "\(Config.tmdbImageBaseURL)/w780\(backdropPath)")
    }
    
    /// 예매율 (popularity를 백분율로 변환)
    var bookingRate: Double {
        let normalizedRate = min(popularity / 100.0, 100.0)
        return normalizedRate
    }
    
    /// 런타임 포맷팅
    var runtimeString: String {
        guard runtime > 0 else { return "정보 없음" }
        return runtime.toTimeString()
    }
    
    /// 장르 문자열
    var genreNames: String {
        return genres.map { $0.name }.joined(separator: ", ")
    }
    
    /// 개봉일 포맷팅
    var releaseDateFormatted: String {
        return releaseDate.toDotDateString()
    }
}

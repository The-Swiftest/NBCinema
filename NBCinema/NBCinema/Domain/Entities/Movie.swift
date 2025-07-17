//
//  Movie.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import Foundation

/// 영화 기본 정보 (목록 화면용)
struct Movie {
    let id: Int
    let title: String
    let posterPath: String?
    let popularity: Double
    let voteAverage: Double
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, title, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}

extension Movie {
    /// 포스터 이미지 URL 반환 (Kingfisher용)
    @inlinable
    var posterURL: URL? {
        posterPath
            .flatMap { URL(string: "\(Config.tmdbImageBaseURL)/w500\($0)") }
    }
    
    /// 예매율 (popularity를 백분율로 변환)
    @inlinable
    var bookingRate: Double {
        // popularity 값을 0~100 범위로 정규화
        min(popularity / 100.0, 100.0)
    }
}

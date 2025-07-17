//
//  MovieListResponse.swift
//  NBCinema
//
//  Created by Milou on 7/17/25.
//

import Foundation

/// 영화 목록 API 응답 (영화목록 + 검색 공통 사용)
struct MovieListResponse: Decodable {
    let results: [Movie]
    let totalResults: Int // 검색 결과 개수 표시용
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalResults = "total_results"
    }
}

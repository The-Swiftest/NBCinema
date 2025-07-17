//
//  GenreListResponse.swift
//  NBCinema
//
//  Created by Milou on 7/17/25.
//

import Foundation

/// 장르 목록 API 응답
struct GenreListResponse: Decodable {
    let genres: [Genre]
}

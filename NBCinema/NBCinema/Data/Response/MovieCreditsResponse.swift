//
//  MovieCreditsResponse.swift
//  NBCinema
//
//  Created by Milou on 7/17/25.
//

import Foundation

/// 영화 크레딧 API 응답 (감독, 출연진 정보용)
struct MovieCreditsResponse: Decodable {
    let id: Int
    let cast: [CastInfo]
    let crew: [CrewInfo]
    
    /// 감독 정보 추출
    var director: String? {
        return crew.first(where: { $0.job == "Director" })?.name
    }
    
    /// 주요 출연진 (상위 5명)
    var mainCast: [String] {
        return Array(cast.prefix(5).map { $0.name })
    }
}

struct CastInfo: Decodable {
    let name: String
}

struct CrewInfo: Decodable {
    let name: String
    let job: String
}

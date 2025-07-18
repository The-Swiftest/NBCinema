//
//  MovieSection.swift
//  NBCinema
//
//  Created by Milou on 7/18/25.
//

import Foundation

enum MovieSection: Int, CaseIterable {
    case nowPlaying = 0
    case upcoming = 1
    case topRated = 2
    case popular = 3
    
    var title: String {
        switch self {
        case .nowPlaying:
            return "현재 상영작 순위"
        case .upcoming:
            return "상영 예정"
        case .topRated:
            return "높은 평점"
        case .popular:
            return "인기 영화"
        }
    }
    
    var showHeader: Bool {
        switch self {
        case .nowPlaying:
            return false
        default:
            return true
        }
    }
}

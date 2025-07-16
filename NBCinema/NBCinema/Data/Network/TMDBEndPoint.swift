//
//  TMDBEndPoint.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import Foundation

enum TMDBEndPoint {
    case popular // 상영중인 인기 순위
    case upcoming
    case nowPlaying
    case topRated
    case movieDetail(Int)
    case search(query: String)
    case genres
    
    var url: URL {
        guard let url = URL(string: fullURL) else {
            fatalError("❌ Invalid URL")
        }
        return url
    }
    
    var fullURL: String {
        return Config.tmdbBaseURL + path + parameters
    }
    
    private var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .upcoming:
            return "movie/upcoming"
        case .nowPlaying:
            return "movie/now_playing"
        case .topRated:
            return "movie/top_rated"
        case .movieDetail(let id):
            return "/movie/\(id)"
        case .search(query: let query):
            return "/search/movie"
        case .genres:
            return "/genre/movie/list"
        }
    }
    
    private var parameters: String {
        let baseParams = "?language=\(Config.language)&region=\(Config.region)"
        
        switch self {
        case .search(let query):
            let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return baseParams + "&query=\(encodedQuery)"
        case .movieDetail:
            return baseParams + "&append_to_response=credits"
        default:
            return baseParams
        }
    }
}

//
//  TMDBEndPoint.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import Foundation

enum TMDBEndPoint {
    case nowPlaying // 상영중, 인기 순
    case popular
    case upcoming
    case topRated
    case movieDetail(Int)
    case movieCredits(id: Int)
    case search(query: String)
    case moviesByGenre(genreId: Int)
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
        case .nowPlaying:
            return "/movie/now_playing"
        case .popular:
            return "/movie/popular"
        case .upcoming:
            return "/movie/upcoming"
        case .topRated:
            return "/movie/top_rated"
        case .movieDetail(let id):
            return "/movie/\(id)"
        case .movieCredits(let id):
            return "/movie/\(id)/credits"
        case .search(query: _):
            return "/search/movie"
        case .moviesByGenre(genreId: _):
            return "/discover/movie"
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
        case .moviesByGenre(let genreId):  
            return baseParams + "&with_genres=\(genreId)"
        default:
            return baseParams
        }
    }
}

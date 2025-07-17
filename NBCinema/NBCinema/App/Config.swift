//
//  Config.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import Foundation

struct Config {
    static let tmdbBaseURL = "https://api.themoviedb.org/3"
    static let tmdbImageBaseURL = "https://image.tmdb.org/t/p"
    static let language = "ko-KR"
    static let region = "KR"
    
    static var tmdbAPIKey: String {
        guard let apiKey = Bundle.main.apiKey else {
            fatalError("❌ TMDB API Key")
        }
        return apiKey
    }
}

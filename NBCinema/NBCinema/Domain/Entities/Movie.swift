//
//  Movie.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let genres: [Genre]
    let runtime: Int?
    let originalLanguage: String
    let originalTitle: String
    let adult: Bool
    let popularity: Double
}

struct Genre {
    let id: Int
    let name: String
}

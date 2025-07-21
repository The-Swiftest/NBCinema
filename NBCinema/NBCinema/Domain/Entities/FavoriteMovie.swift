//
//  FavoriteMovie.swift
//  NBCinema
//
//  Created by seongjun cho on 7/21/25.
//

import Foundation

import RealmSwift

class FavoriteMovie: Object {
    @Persisted var movieTitle: String
    @Persisted var runtime: Int
    @Persisted var genres = List<FavoriteMovieGenre>()
    @Persisted var posterPath: String

    convenience init(movieTitle: String,
                     runtime: Int,
                     genres: [Genre],
                     posterPath: String) {
        self.init()
        self.movieTitle = movieTitle
        self.runtime = runtime
        self.posterPath = posterPath

        let favoriteMovieGenres =  genres.map { genre in
            FavoriteMovieGenre(id: genre.id, name: genre.name)
        }
        self.genres.append(objectsIn: favoriteMovieGenres)
    }

    var posterURL: URL? {
        URL(string: "\(Config.tmdbImageBaseURL)/w500\(posterPath)")
    }
}

class FavoriteMovieGenre: Object {
    @Persisted var id: Int
    @Persisted var name: String

    convenience init(id: Int, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}

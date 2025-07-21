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

    convenience init(movieTitle: String,
                     runtime: Int,
                     genres: [Genre]) {
        self.init()
        self.movieTitle = movieTitle
        self.runtime = runtime

        let favoriteMovieGenres =  genres.map { genre in
            FavoriteMovieGenre(id: genre.id, name: genre.name)
        }
        self.genres.append(objectsIn: favoriteMovieGenres)
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

//
//  MovieItem.swift
//  NBCinema
//
//  Created by Milou on 7/21/25.
//

import Foundation

struct MovieItem: Hashable {
    let movie: Movie
    let section: MovieSection
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(section.rawValue)
        hasher.combine(movie.id)
    }
    
    static func == (lhs: MovieItem, rhs: MovieItem) -> Bool {
        return lhs.movie.id == rhs.movie.id && lhs.section == rhs.section
    }
}

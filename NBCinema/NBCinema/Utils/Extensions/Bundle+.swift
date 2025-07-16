//
//  Bundle+.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import Foundation

extension Bundle {
    var apiKey: String? {
        return infoDictionary?["TMDB_API_KEY"] as? String
    }
}

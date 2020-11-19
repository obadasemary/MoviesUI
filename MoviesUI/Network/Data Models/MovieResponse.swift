//
//  MovieResponse.swift
//  MoviesOMDB
//
//  Created by Abdelrahman Mohamed on 27.09.2020.
//

import Foundation

struct MovieResponse: Decodable {

    let movies: [Movie]

    private enum CodingKeys: String, CodingKey {
        case movies = "Search"
    }
}

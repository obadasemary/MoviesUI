//
//  URLBuilder.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 23.11.2020.
//

import Foundation

class URLBuilder {

    enum Constants {
        static let imageBaseUrl = "https://image.tmdb.org/t/p/w"
    }

    static func imageUrl(path: String, width: Int = 500) -> String? {

        return "\(Constants.imageBaseUrl)\(width)\(path)"
    }
}

//
//  MovieGallery.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 10.12.2020.
//

import Foundation

// MARK: - MovieGallery
struct MovieGallery: Codable {
    let id: Int?
    let backdrops, posters: [Backdrop]?
}

// MARK: - Backdrop
struct Backdrop: Codable, Hashable {
    
    let aspectRatio: Double?
    let filePath: String?
    let height: Int?
    let iso639_1: String?
    let voteAverage: Double?
    let voteCount, width: Int?

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case iso639_1 = "iso_639_1"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}

extension Backdrop: Identifiable {
    var id: UUID {
        return UUID()
    }
}

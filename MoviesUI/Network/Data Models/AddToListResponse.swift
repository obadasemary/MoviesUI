//
//  AddToListResponse.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 17.12.2020.
//

import Foundation

// MARK: - AddToListResponse
struct AddToListResponse: Codable {
    let success: Bool?
    let statusCode: Int?
    let statusMessage: String?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

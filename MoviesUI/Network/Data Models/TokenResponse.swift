//
//  TokenResponse.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 16.12.2020.
//

import Foundation

// MARK: - TokenResponse
struct TokenResponse: Codable {
    
    let success: Bool?
    let expiresAt, requestToken: String?

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}

// MARK: - CreateSessionResponse
struct CreateSessionResponse: Codable {
    let success: Bool?
    let sessionID: String?

    enum CodingKeys: String, CodingKey {
        case success
        case sessionID = "session_id"
    }
}


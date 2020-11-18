//
//  Headers.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 18.11.2020.
//

import Foundation

func headers() -> [String: String] {
    
    var headers = [String: String]()
    headers["Content-Type"] = "application/json"
//    headers["X-Authorization"] = AuthorizationDataManager().getBearerToken()
//    headers["X-Lang"] = UserManager.shared.getLanguage().rawValue
    
    //headers["Accept-Language"] = UserManager.shared.getLanguage().rawValue
    return headers
}

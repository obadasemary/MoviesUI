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
    headers["Accept"] = "application/json"
    headers["X-OS-Name"] = "ios"
    headers["User-Agent"] = "iOSMobileApp"
    headers["Cache-Control"] = "no-cache"
    
    return headers
}

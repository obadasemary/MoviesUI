//
//  CountriesWithCitiesResponse.swift
//  Cardial
//
//  Created by Abdelrahman Mohamed on 12.11.2020.
//

import Foundation

// MARK: - CountriesWithCitiesResponse
struct CountriesWithCitiesResponse: Codable {
    let status: Status?
    let data: [CountryWithCities]?
}

// MARK: - Datum
struct CountryWithCities: Codable, Identifiable {
    let id, name, stateKey: String?
    let flag: String?
    let cities: [String]?
}

class Status: NSObject, NSCoding, Codable {

    var code: Int?
    var message: String?
    var success: Bool?
    
    override init() {}
    
    init(code: Int, message: String?, success: Bool?) {
        self.code = code
        self.message = message
        self.success = success
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        code = aDecoder.decodeObject(forKey: "code") as? Int
        message = aDecoder.decodeObject(forKey: "message") as? String
        success = aDecoder.decodeObject(forKey: "success") as? Bool
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder) {
        if code != nil {
            aCoder.encode(code, forKey: "code")
        }
        if message != nil {
            aCoder.encode(message, forKey: "message")
        }
        if success != nil {
            aCoder.encode(success, forKey: "success")
        }
    }
}

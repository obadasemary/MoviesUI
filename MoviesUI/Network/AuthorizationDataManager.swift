//
//  AuthorizationDataManager.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 18.11.2020.
//  Copyright © 2020 Abdelrahman Mohamed. All rights reserved.
//

import Foundation

protocol AuthorizationDataManagerType {
    func saveAuthorizationSession(sessionId: String)
    func getAuthorizationSession() -> String?
    func saveAuthorizationProfile(model: ProfileResponse)
    func getAuthorizationProfile() -> ProfileResponse?
    func clearAuthorization()
}

class AuthorizationDataManager: AuthorizationDataManagerType {

    static let shared = AuthorizationDataManager()
    private let sessionIdKey = "sessionId"
    private let profileModelKey = "profileModelKey"
    
    func saveAuthorizationSession(sessionId: String) {
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.set(sessionId, forKey: sessionIdKey)
        } catch {
            print(error.localizedDescription)
        }
    }

    func getAuthorizationSession() -> String? {
        let userDefaults = UserDefaults.standard
        do {
            let sessionId = try userDefaults.object(forKey: sessionIdKey)
            print(sessionId)
            return sessionId as? String
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveAuthorizationProfile(model: ProfileResponse) {
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.setObject(model, forKey: profileModelKey)
        } catch {
            print(error.localizedDescription)
        }
    }

    func getAuthorizationProfile() -> ProfileResponse? {
        let userDefaults = UserDefaults.standard
        do {
            let model = try userDefaults.getObject(forKey: profileModelKey, castTo: ProfileResponse.self)
            print(model.id)
            return model
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func clearAuthorization() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: sessionIdKey)
    }
}

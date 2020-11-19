////
////  AuthorizationDataManager.swift
////  MoviesUI
////
////  Created by Abdelrahman Mohamed on 18.11.2020.
////  Copyright © 2020 Abdelrahman Mohamed. All rights reserved.
////
//
//import Foundation
//
//private let authModelKey = "authModelKey"
//
//protocol AuthorizationDataManagerType {
////    func saveAuthorizationModel(model: LoginRootModel)
////    func getAuthorizationModel() -> LoginRootModel?
////    func getBearerToken() -> String?
////    func clearAuthorization()
//}
//
//class AuthorizationDataManager: AuthorizationDataManagerType {
//    
//    static let shared = AuthorizationDataManager()
//    
////    var isLoggedIn: Bool {
////        return getAuthorizationModel() != nil
////    }
//    
////    func saveAuthorizationModel(model: LoginRootModel) {
////        let playingItMyWay = model
////        let userDefaults = UserDefaults.standard
////        do {
////            try userDefaults.setObject(playingItMyWay, forKey: authModelKey)
////        } catch {
////            print(error.localizedDescription)
////        }
////    }
////
////    func getAuthorizationModel() -> LoginRootModel? {
////        let userDefaults = UserDefaults.standard
////        do {
////            let playingItMyWay = try userDefaults.getObject(forKey: authModelKey, castTo: LoginRootModel.self)
////            print(playingItMyWay)
////            return playingItMyWay
////        } catch {
////            print(error.localizedDescription)
////            return nil
////        }
////    }
//    
////    func clearAuthorization() {
////        let defaults = UserDefaults.standard
////        defaults.removeObject(forKey: authModelKey)
////    }
////    
////    func getBearerToken() -> String? {
////        print(getAuthorizationModel()?.data?.credentials!.accessToken ?? "No Access token")
////        if let token = getAuthorizationModel()?.data?.credentials!.accessToken {
////            return token
////        }
////        return ""
////    }
////
////    func getToken() -> String {
////        guard let token = getAuthorizationModel()?.data?.credentials!.accessToken else {
////            return ""
////        }
////        return token
////    }
////    
////    func getEmail() -> String {
////            
////        guard let email = getAuthorizationModel()?.data?.customer?.email else {
////            return ""
////        }
////        
////        return email
////    }
//}

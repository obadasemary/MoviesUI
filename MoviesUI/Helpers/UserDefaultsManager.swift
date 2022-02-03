//
//  UserDefaultsManager.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 2.02.2022.
//

import Foundation

public enum StorageKey: String {

    case is3rdPartyAuthenticationRequestAccepted
    case username
    case password

}

public protocol UserDefaultsManagerProtocol: AnyObject {

    var is3rdPartyAuthenticationRequestAccepted: Bool { get set }
    var username: String { get set }
    var password: String { get set }
}

public class UserDefaultsManager: UserDefaultsManagerProtocol {

    public static let shared = UserDefaultsManager()

    private let defaults = UserDefaults.standard
    
    public var is3rdPartyAuthenticationRequestAccepted: Bool {
        get {
            defaults.bool(forKey: StorageKey.is3rdPartyAuthenticationRequestAccepted.rawValue)
        }
        set(value) {
            defaults.set(value, forKey: StorageKey.is3rdPartyAuthenticationRequestAccepted.rawValue)
        }
    }

    public var username: String {
        get {
            defaults.string(forKey: StorageKey.username.rawValue) ?? ""
        }
        set(value) {
            defaults.set(value, forKey: StorageKey.username.rawValue)
        }
    }

    public var password: String {
        get {
            defaults.string(forKey: StorageKey.password.rawValue) ?? ""
        }
        set(value) {
            defaults.set(value, forKey: StorageKey.password.rawValue)
        }
    }
}

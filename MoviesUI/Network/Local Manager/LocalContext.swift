//
//  LocalContext.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 18.11.2020.
//

import Foundation

class LocalContext {
    
    // MARK: - helpers -
    func readFromBundle<A: Codable>(resource: String, type: String) -> A? {
        let testBundle = Bundle(for: LocalContext.self)
        if let path = testBundle.path(forResource: resource, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let model = try? JSONDecoder().decode(A.self, from: data)
                return model
            } catch {
                assertionFailure("failed import json")
            }
        }
        return nil
    }
    
    func readFromBundle<A: Codable>(resource: String, type: String) -> [A]? {
        let testBundle = Bundle(for: LocalContext.self)
        if let path = testBundle.path(forResource: resource, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let model = try? JSONDecoder().decode([A].self, from: data)
                return model
            } catch {
                assertionFailure("failed import json")
            }
        }
        return nil
    }
}

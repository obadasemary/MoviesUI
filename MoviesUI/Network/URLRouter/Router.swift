//
//  Router.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 18.11.2020.
//
//  Source of this file
//  https://github.com/chaione/RoutableApp
//  https://chaione.com/blog/routers-swift-protocol-oriented-1/
//  https://chaione.com/blog/routers-swift-protocol-oriented-programming-pt-2/
//  https://drama-spares.com/rest-api/docs/
import Foundation

struct Router: URLRouter {
    
    static var basePath: String {
        return "https://drama-spares.com/wp-json/v1/"
    }
 
    struct getCountriesWithCities: Readable {
        var urlParams: String!
        var route: String = "cities"
    }
}

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

struct Constants {
    
    static let API_KEY = "a22cefd9"
    
    static let pathS = "http://www.omdbapi.com/?s="
    static let pathI = "http://www.omdbapi.com/?i="
    static let apiKeyString = "&apikey="
    static let fullPath = "http://www.omdbapi.com/?s=spiderman&apikey=a22cefd9"
    
//    Constants.pathS + search + Constants.apiKeyString + Constants.API_KEY
}


struct Router: URLRouter {
    
    static var basePath: String {
//        return "https://drama-spares.com/wp-json/v1/"
        return "http://www.omdbapi.com"
    }
    
    struct getMovieList: Readable {
        var urlParams: String!
        var route: String = ""
    }
 
//    struct getCountriesWithCities: Readable {
//        var urlParams: String!
//        var route: String = "cities"
//    }
}

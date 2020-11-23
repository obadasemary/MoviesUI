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

enum apiURLConstants {
    
    static let apiURL = "https://api.themoviedb.org/3"
    static let apiKey = "44258121c0a1dbc3f3859f7f4b32bb07"
}


struct Router: URLRouter {
    
    static var basePath: String {
//        return "http://www.omdbapi.com"
        return apiURLConstants.apiURL
    }
    
    struct getTopRatedMovieList: Readable {
        var urlParams: String!
        var route: String = "movie/top_rated"
    }
    
    struct getMovieList: Readable {
        var urlParams: String!
        var route: String = ""
    }
}

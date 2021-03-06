//
//  Router.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 18.11.2020.
//
//  Source of this file
//  https://github.com/chaione/RoutableApp
//  https://blog.chaione.com/blog/routers-swift-protocol-oriented-1
//  https://blog.chaione.com/blog/routers-swift-protocol-oriented-programming-pt-2

import Foundation

struct Constants {
    
    static let API_KEY = "a22cefd9"
    
    static let pathS = "http://www.omdbapi.com/?s="
    static let pathI = "http://www.omdbapi.com/?i="
    static let apiKeyString = "&apikey="
    static let fullPath = "http://www.omdbapi.com/?s=spiderman&apikey=a22cefd9"
    
//    Constants.pathS + search + Constants.apiKeyString + Constants.API_KEY
}

var defaultUrlParams: [String: String] {
    return [
        "api_key": "44258121c0a1dbc3f3859f7f4b32bb07"
    ]
}

enum apiURLConstants {
    
    static let apiURL = "https://api.themoviedb.org/3"
    static let apiKey = "44258121c0a1dbc3f3859f7f4b32bb07"
}


struct Router: URLRouter {
    
    static var basePath: String {
        return apiURLConstants.apiURL
    }
    
    struct getTopRatedMovieList: Readable {
        var urlParams: String!
        var route: String = "movie/top_rated"
    }
    
    struct getUpcomingMovieList: Readable {
        var urlParams: String!
        var route: String = "movie/upcoming"
    }
    
    struct getNowPlayingMovieList: Readable {
        var urlParams: String!
        var route: String = "movie/now_playing"
    }
    
    struct getPopularMovieList: Readable {
        var urlParams: String!
        var route: String = "movie/popular"
    }
    
    struct getMovieDetails: Readable {
        var urlParams: String!
        var route: String = "movie"
    }
    
    struct search: Readable {
        var urlParams: String!
        var route: String = "search/movie"
    }
    
    struct createRequestToken: Readable {
        var urlParams: String!
        var route: String = "authentication/token/new"
    }
    
    struct createSessionWithLogin: Creatable {
        var urlParams: String!
        var route: String = "authentication/token/validate_with_login"
    }
    
    struct createSession: Creatable {
        var urlParams: String!
        var route: String = "authentication/session/new"
    }
    
    struct account: Readable, Creatable {
        var urlParams: String!
        var route: String = "account"
    }
}

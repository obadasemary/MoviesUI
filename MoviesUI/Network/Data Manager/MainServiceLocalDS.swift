//
//  MainServiceLocalDS.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 18.11.2020.
//

import Foundation
import Combine

class MainServiceLocalDS: MainServicesRepoType {
    
    var context: LocalContext

    init(context: LocalContext) {
        self.context = context
    }
    
    func getTopRatedMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func getUpcomingMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func getNowPlayingMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func getPopularMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func getMovieDetails(movieId: Int) -> AnyPublisher<Movie, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func getMovieGallery(movieId: Int) -> AnyPublisher<MovieGallery, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func getRecommendationsMovieList(movieId: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func search(query: String, page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func createRequestToken() -> AnyPublisher<TokenResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func createSessionWithLogin(username: String, password: String, requestToken: String) -> AnyPublisher<TokenResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func createSession(requestToken: String) -> AnyPublisher<CreateSessionResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func getAccountDetails(sessionId: String) -> AnyPublisher<ProfileResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func getMovieWatchlist(page: Int, sessionId: String, accountId: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func getMovieFavoritelist(page: Int, sessionId: String, accountId: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func addMovieToWatchlist(movieId: Int, sessionId: String, accountId: Int) -> AnyPublisher<AddToListResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
    
    func addMovieToFavoritelist(movieId: Int, sessionId: String, accountId: Int) -> AnyPublisher<AddToListResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
}

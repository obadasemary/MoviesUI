//
//  ServiceRepo.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 18.11.2020.
//

import Foundation
import Combine

protocol MainServicesRepoType {
    
    func getTopRatedMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError>
    func getUpcomingMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError>
    func getNowPlayingMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError>
    func getPopularMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError>
    func getMovieDetails(movieId: Int) -> AnyPublisher<Movie, APIError>
    func getMovieGallery(movieId: Int) -> AnyPublisher<MovieGallery, APIError>
    func getRecommendationsMovieList(movieId: Int) -> AnyPublisher<MovieListResponse, APIError>
    func search(query: String, page: Int) -> AnyPublisher<MovieListResponse, APIError>
    func createRequestToken() -> AnyPublisher<TokenResponse, APIError>
    func createSessionWithLogin(username: String, password: String, requestToken: String) -> AnyPublisher<TokenResponse, APIError>
    func createSession(requestToken: String) -> AnyPublisher<CreateSessionResponse, APIError>
    func getAccountDetails(sessionId: String) -> AnyPublisher<ProfileResponse, APIError>
    func getMovieWatchlist(page: Int, sessionId: String, accountId: Int) -> AnyPublisher<MovieListResponse, APIError>
    func getMovieFavoritelist(page: Int, sessionId: String, accountId: Int) -> AnyPublisher<MovieListResponse, APIError>
    func addMovieToWatchlist(movieId: Int, sessionId: String, accountId: Int) -> AnyPublisher<AddToListResponse, APIError>
    func addMovieToFavoritelist(movieId: Int, sessionId: String, accountId: Int) -> AnyPublisher<AddToListResponse, APIError>
}

final class MainServicesRepo: MainServicesRepoType {
    
    var remoteDS: MainServicesRepoType
    var localDS: MainServicesRepoType
    
    init(localDS: MainServicesRepoType, remoteDS: MainServicesRepoType) {
        self.localDS = localDS
        self.remoteDS = remoteDS
    }
    
    func getTopRatedMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return self.remoteDS.getTopRatedMovieList(page: page)
    }
    
    func getUpcomingMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return self.remoteDS.getUpcomingMovieList(page: page)
    }
    
    func getNowPlayingMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return self.remoteDS.getNowPlayingMovieList(page: page)
    }
    
    func getPopularMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return self.remoteDS.getPopularMovieList(page: page)
    }
    
    func getMovieDetails(movieId: Int) -> AnyPublisher<Movie, APIError> {
        return self.remoteDS.getMovieDetails(movieId: movieId)
    }
    
    func getMovieGallery(movieId: Int) -> AnyPublisher<MovieGallery, APIError> {
        return self.remoteDS.getMovieGallery(movieId: movieId)
    }
    
    func getRecommendationsMovieList(movieId: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return self.remoteDS.getRecommendationsMovieList(movieId: movieId)
    }
    
    func search(query: String, page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return self.remoteDS.search(query: query, page: page)
    }
    
    func createRequestToken() -> AnyPublisher<TokenResponse, APIError> {
        return self.remoteDS.createRequestToken()
    }
    
    func createSessionWithLogin(username: String, password: String, requestToken: String) -> AnyPublisher<TokenResponse, APIError> {
        return self.remoteDS.createSessionWithLogin(username: username, password: password, requestToken: requestToken)
    }
    
    func createSession(requestToken: String) -> AnyPublisher<CreateSessionResponse, APIError> {
        return self.remoteDS.createSession(requestToken: requestToken)
    }
    
    func getAccountDetails(sessionId: String) -> AnyPublisher<ProfileResponse, APIError> {
        return self.remoteDS.getAccountDetails(sessionId: sessionId)
    }
    
    func getMovieWatchlist(page: Int, sessionId: String, accountId: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return self.remoteDS.getMovieWatchlist(page: page, sessionId: sessionId, accountId: accountId)
    }
    
    func getMovieFavoritelist(page: Int, sessionId: String, accountId: Int) -> AnyPublisher<MovieListResponse, APIError> {
        return self.remoteDS.getMovieFavoritelist(page: page, sessionId: sessionId, accountId: accountId)
    }
    
    func addMovieToWatchlist(movieId: Int, sessionId: String, accountId: Int) -> AnyPublisher<AddToListResponse, APIError> {
        return self.remoteDS.addMovieToWatchlist(movieId: movieId, sessionId: sessionId, accountId: accountId)
    }
    
    func addMovieToFavoritelist(movieId: Int, sessionId: String, accountId: Int) -> AnyPublisher<AddToListResponse, APIError> {
        return self.remoteDS.addMovieToFavoritelist(movieId: movieId, sessionId: sessionId, accountId: accountId)
    }
}

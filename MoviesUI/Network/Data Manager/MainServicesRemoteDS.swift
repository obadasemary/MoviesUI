//
//  MainServicesRemoteDS.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 18.11.2020.
//

import Foundation
import Combine

class MainServicesRemoteDS: MainServicesRepoType {
    
    let context: RemoteContextRequestsProtocol
    var urlComponents = URLComponents()

    init(context: RemoteContextRequestsProtocol) {
        self.context = context
    }
    
    func getTopRatedMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        
        let newKeyValues = [
            "language": "en",
            "page": String(page)
        ]
        
        let parameters = defaultUrlParams.merging(newKeyValues) { (current, _) in current }
        urlComponents.setQueryItems(with: parameters)

        let router = Router.getTopRatedMovieList.get(params: "", httpHeaders: headers(), queryItems: urlComponents.queryItems)
        let publisher: AnyPublisher<MovieListResponse, APIError> = context.doRequest(request: router)
        return publisher
    }
    
    func getUpcomingMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        
        let newKeyValues = [
            "language": "en",
            "page": String(page)
        ]
        
        let parameters = defaultUrlParams.merging(newKeyValues) { (current, _) in current }
        urlComponents.setQueryItems(with: parameters)

        let router = Router.getUpcomingMovieList.get(params: "", httpHeaders: headers(), queryItems: urlComponents.queryItems)
        let publisher: AnyPublisher<MovieListResponse, APIError> = context.doRequest(request: router)
        return publisher
    }
    
    func getNowPlayingMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        
        let newKeyValues = [
            "language": "en",
            "page": String(page)
        ]
        
        let parameters = defaultUrlParams.merging(newKeyValues) { (current, _) in current }
        urlComponents.setQueryItems(with: parameters)

        let router = Router.getNowPlayingMovieList.get(params: "", httpHeaders: headers(), queryItems: urlComponents.queryItems)
        let publisher: AnyPublisher<MovieListResponse, APIError> = context.doRequest(request: router)
        return publisher
    }
    
    func getPopularMovieList(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        
        let newKeyValues = [
            "language": "en",
            "page": String(page)
        ]
        
        let parameters = defaultUrlParams.merging(newKeyValues) { (current, _) in current }
        urlComponents.setQueryItems(with: parameters)

        let router = Router.getPopularMovieList.get(params: "", httpHeaders: headers(), queryItems: urlComponents.queryItems)
        let publisher: AnyPublisher<MovieListResponse, APIError> = context.doRequest(request: router)
        return publisher
    }
    
    func getMovieDetails(movieId: Int) -> AnyPublisher<Movie, APIError> {
        
        urlComponents.setQueryItems(with: defaultUrlParams)

        let router = Router.getMovieDetails.get(params: "\(movieId)", httpHeaders: headers(), queryItems: urlComponents.queryItems)
        let publisher: AnyPublisher<Movie, APIError> = context.doRequest(request: router)
        return publisher
    }
    
    func getMovieGallery(movieId: Int) -> AnyPublisher<MovieGallery, APIError> {
        
        urlComponents.setQueryItems(with: defaultUrlParams)

        let router = Router.getMovieDetails.get(params: "\(movieId)/images", httpHeaders: headers(), queryItems: urlComponents.queryItems)
        let publisher: AnyPublisher<MovieGallery, APIError> = context.doRequest(request: router)
        return publisher
    }
    
    func getRecommendationsMovieList(movieId: Int) -> AnyPublisher<MovieListResponse, APIError> {
        
        urlComponents.setQueryItems(with: defaultUrlParams)

        let router = Router.getMovieDetails.get(params: "\(movieId)/recommendations", httpHeaders: headers(), queryItems: urlComponents.queryItems)
        let publisher: AnyPublisher<MovieListResponse, APIError> = context.doRequest(request: router)
        return publisher
    }
    
    func search(query: String, page: Int) -> AnyPublisher<MovieListResponse, APIError> {
        
        let newKeyValues = [
            "query": query,
            "page": String(page)
        ]
        
        let parameters = defaultUrlParams.merging(newKeyValues) { (current, _) in current }
        urlComponents.setQueryItems(with: parameters)

        let router = Router.search.get(params: "", httpHeaders: headers(), queryItems: urlComponents.queryItems)
        let publisher: AnyPublisher<MovieListResponse, APIError> = context.doRequest(request: router)
        return publisher
    }
    
    func createRequestToken() -> AnyPublisher<TokenResponse, APIError> {
        
        urlComponents.setQueryItems(with: defaultUrlParams)

        let router = Router.createRequestToken.get(params: "", httpHeaders: headers(), queryItems: urlComponents.queryItems)
        let publisher: AnyPublisher<TokenResponse, APIError> = context.doRequest(request: router)
        return publisher
    }
    
    func createSessionWithLogin(username: String, password: String, requestToken: String) -> AnyPublisher<TokenResponse, APIError> {
        
        urlComponents.setQueryItems(with: defaultUrlParams)
        
        var parmameters = [String: String]()
        
        parmameters["username"] = username
        parmameters["password"] = password
        parmameters["request_token"] = requestToken
        
        let router = Router.createSessionWithLogin.create(parameters: parmameters, httpHeaders: headers(), queryItems: urlComponents.queryItems)
        let publisher: AnyPublisher<TokenResponse, APIError> = context.doRequest(request: router)
        return publisher
    }
    
    func createSession(requestToken: String) -> AnyPublisher<CreateSessionResponse, APIError> {
        
        urlComponents.setQueryItems(with: defaultUrlParams)
        
        var parmameters = [String: String]()
        parmameters["request_token"] = requestToken
        
        let router = Router.createSession.create(parameters: parmameters, httpHeaders: headers(), queryItems: urlComponents.queryItems)
        let publisher: AnyPublisher<CreateSessionResponse, APIError> = context.doRequest(request: router)
        return publisher
    }
}

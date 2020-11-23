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

    init(context: RemoteContextRequestsProtocol) {
        self.context = context
    }
    
    func getTopRatedMovieList() -> AnyPublisher<MovieListResponse, APIError> {
        let params = [URLQueryItem(name: "api_key", value: apiURLConstants.apiKey)]
        let router = Router.getTopRatedMovieList.get(params: "", httpHeaders: headers(), queryItems: params)
        let publisher: AnyPublisher<MovieListResponse, APIError> = context.doRequest(request: router)
        return publisher
    }

//    func getCountriesWithCities() -> AnyPublisher<MovieResponse, APIError> {
//        let params = [URLQueryItem(name: "s", value: "spiderman"), URLQueryItem(name: "apikey", value: "a22cefd9")]
//        let router = Router.getMovieList.get(params: "", httpHeaders: headers(), queryItems: params)
//        let publisher: AnyPublisher<MovieResponse, APIError> = context.doRequest(request: router)
//        return publisher
//    }
}

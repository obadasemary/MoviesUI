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
}

//
//  ServiceRepo.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 18.11.2020.
//

import Foundation
import Combine

protocol MainServicesRepoType {
    
//    func getCountriesWithCities() -> AnyPublisher<MovieResponse, APIError>
    func getTopRatedMovieList() -> AnyPublisher<MovieListResponse, APIError>
}

final class MainServicesRepo: MainServicesRepoType {
    
    var remoteDS: MainServicesRepoType
    var localDS: MainServicesRepoType
    
    init(localDS: MainServicesRepoType, remoteDS: MainServicesRepoType) {
        self.localDS = localDS
        self.remoteDS = remoteDS
    }
    
    func getTopRatedMovieList() -> AnyPublisher<MovieListResponse, APIError> {
        return self.remoteDS.getTopRatedMovieList()
    }

//    func getCountriesWithCities() -> AnyPublisher<MovieResponse, APIError> {
//        return self.remoteDS.getCountriesWithCities()
//    }
}

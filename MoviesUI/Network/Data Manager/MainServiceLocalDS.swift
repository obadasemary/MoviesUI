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
    
    func getTopRatedMovieList() -> AnyPublisher<MovieListResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }

//    func getCountriesWithCities() -> AnyPublisher<MovieResponse, APIError> {
//        return Empty().eraseToAnyPublisher()
//    }
}

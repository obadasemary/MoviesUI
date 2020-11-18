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

    func getCountriesWithCities() -> AnyPublisher<CountriesWithCitiesResponse, APIError> {
        return Empty().eraseToAnyPublisher()
    }
}

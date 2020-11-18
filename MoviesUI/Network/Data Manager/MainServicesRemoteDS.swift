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

    func getCountriesWithCities() -> AnyPublisher<CountriesWithCitiesResponse, APIError> {
        let router = Router.getCountriesWithCities.get(params: "", httpHeaders: headers())
        let publisher: AnyPublisher<CountriesWithCitiesResponse, APIError> = context.doRequest(request: router)
        return publisher
    }
}

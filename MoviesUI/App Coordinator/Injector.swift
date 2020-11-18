//
//  Injector.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 17.11.2020.
//

import Foundation
import Alamofire

class Injector {
    private static var depenendecyResolver: DependencyResolver {
//        return DependencyResolver(token: AuthorizationDataManager().getBearerToken())
        return DependencyResolver()
    }
    static var mainServiceRepo: MainServicesRepoType = MainServicesRepo(
        localDS: depenendecyResolver.getMainServicesLocalDS(),
        remoteDS: depenendecyResolver.getMainServicesRemoteDS()
    )

    //static let errorHandler = depenendecyResolver.errorHandler
    //static var appStatus = APPStatusKey.noState
    //static let deeplinker = DeepLinkManager()
}


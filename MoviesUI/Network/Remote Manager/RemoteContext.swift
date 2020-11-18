//
//  RemoteContext.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 18.11.2020.
//

import Foundation
import Alamofire
import Combine

protocol RemoteContextRequestsProtocol {
    //func cancelAllRequests()
    func doRequest<T: Decodable>(request: URLRequestConvertible) -> AnyPublisher<T, APIError>
    //func doRequest<T: Decodable>(request: URLRequestConvertible) -> AnyPublisher<[T], APIError>
    //    func doRequest(request:URLRequestConvertible) -> Observable<Any>
    func doRequest(request: URLRequestConvertible) -> AnyPublisher<String, APIError>
    func doRequest(request: URLRequestConvertible) -> AnyPublisher<Data, APIError>
    //func doRequest(request: URLRequestConvertible) -> AnyPublisher<Void, APIError>
}

class RemoteContext: NSObject, RemoteContextRequestsProtocol {
    
    let sessionManager: SessionManager
    
    init(session: SessionManager) {
        self.sessionManager = session
    }
    
    func doRequest<T: Decodable>(request: URLRequestConvertible) -> AnyPublisher<T, APIError> {
        return self.sessionManager.session.request(request).validate()
            .publishDecodable(type: T.self)
            .tryMap { dataResponse -> T in
                if let model = dataResponse.value, dataResponse.response?.statusCode == 200 {
                    return model
                }
                throw handleError(dataResponse: dataResponse.response, data: dataResponse.data)
            }
            .mapError { afError -> APIError in
                return afError as! APIError
            }
            .eraseToAnyPublisher()
    }
    
    func doRequest(request: URLRequestConvertible) -> AnyPublisher<String, APIError> {
        return self.sessionManager.session.request(request).publishString()
            .value()
            .mapError { _ in APIError(message: "SomethingWentWrong", errorCode: .badRequest) }
            .eraseToAnyPublisher()
    }
    
    func doRequest(request: URLRequestConvertible) -> AnyPublisher<Data, APIError> {
        return self.sessionManager.session.request(request).publishData()
            .value()
            .mapError { _ in APIError(message: "SomethingWentWrong", errorCode: .badRequest) }
            .eraseToAnyPublisher()
    }
}

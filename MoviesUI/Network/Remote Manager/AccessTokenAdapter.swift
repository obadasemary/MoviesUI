//
//  AccessTokenAdapter.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 18.11.2020.
//

import Foundation
import Alamofire

class AccessTokenAdapter: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
//        if let token = AuthorizationDataManager().getBearerToken() {
//            urlRequest.setValue(token, forHTTPHeaderField: "X-Authorization")
//        }
        completion(.success(urlRequest))
    }
//
    func retry(_ request: Alamofire.Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            //, self.refreshParam.getRefreshTokenURL().url?.lastPathComponent != request.request?.url?.lastPathComponent {
            //AuthorizationDataManager().clearAuthorization()
            print("renew refresh: ",error, " ", request.request?.url?.lastPathComponent ?? "-/-")
            completion(.doNotRetry)
        } else {
            completion(.doNotRetry)
        }
    }
}

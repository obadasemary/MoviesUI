//
//  RemoteErrorHandler.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 18.11.2020.
//

import Foundation

enum ErrorCode: Int {
    case notFound = 404
    case serverError = 500
    case forbidden = 403
    case unAuthorized = 401
    case badRequest = 400
    case invalidInput = 422
    case unKnown = 000
    case noInternet = 13
}

let genericError = APIError(message: "SomethingWentWrong", errorCode: .unKnown)

struct APIError: Error {
    var message: String
    var errorCode: ErrorCode
}

func handleError(dataResponse: HTTPURLResponse?, data: Data?) -> APIError {
    if let data = data, let error = try? JSONDecoder().decode(ErrorModel.self, from: data) {
        return APIError(message: error.message, errorCode: ErrorCode(rawValue: dataResponse?.statusCode ?? 0)!)
    }
    return genericError
}

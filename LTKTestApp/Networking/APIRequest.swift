//
//  APIRequst.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import Foundation

protocol APIRequest {
    associatedtype Response = Data
    
    var urlRequest: URLRequest { get }
    func decodeResponse(data: Data) throws -> Response
}

enum APIRequestError: Error {
    case error(error: String)
    case invalidResponse(response: String)
    case invalidData
    case decodingError(error: String)
}

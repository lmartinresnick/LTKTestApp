//
//  RequestManager.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import Foundation

struct RequestManager<T>: APIRequest where T : Decodable {
    
    let url: URL
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(_ url: URL) {
        self.url = url
    }
    
    var urlRequest: URLRequest {
        return URLRequest(url: url)
    }
    
    func decodeResponse(data: Data) throws -> T {
        let decodedResponse = try decoder.decode(T.self, from: data)
        return decodedResponse
    }
}

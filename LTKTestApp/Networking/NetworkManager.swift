//
//  NetworkManager.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import Foundation

extension Result where Success == Void {
    static var success: Result { .success(()) }
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func sendRequest<Request: APIRequest>(_ request: Request,
                                          completion: @escaping (Result<Request.Response, APIRequestError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request.urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.error(error: "\(String(describing: error))")))
                return
            }
            
            guard response != nil else {
                completion(.failure(.invalidResponse(response: "\(String(describing: error))")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedResponse = try request.decodeResponse(data: data)
                completion(.success(decodedResponse))
            } catch(let error) {
                completion(.failure(.decodingError(error: "\(error)")))
            }
        }
        task.resume()
    }
}

//
//  LTKTestAppTests.swift
//  LTKTestAppTests
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import XCTest
@testable import LTKTestApp

class LTKTestAppTests: XCTestCase {

    func test_noCall_callCountRemainsZero() {
        let sut = makeSUT()

        XCTAssertEqual(sut.requestCalledCount, 0)
    }
    
    func test_noCall_UrlRequest_isNil() {
        let sut = makeSUT()

        XCTAssertNil(sut.requestSent)
    }

    func test_callCountIncreases() {
        let sut = makeSUT()
        let request = MockRequest<Feed>()
        sut.sendRequest(request) { _ in }
        
        XCTAssertEqual(sut.requestCalledCount, 1)
    }
    
    func test_UrlRequest_isValid() {
        let sut = makeSUT()
        let request = MockRequest<Feed>()
        sut.sendRequest(request) { _ in }
        
        XCTAssertEqual(sut.requestSent?.url?.absoluteString, "https://example.com/v1/")
    }
    
    private func makeSUT() -> NetworkManagerSpy {
        NetworkManagerSpy()
    }
    
    private struct MockRequest<T: Decodable>: APIRequest {
        var urlRequest: URLRequest {
            return URLRequest(url: URL(string: "https://example.com/v1/")!)
        }

        func decodeResponse(data: Data) throws -> T {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        }
    }
}

internal class NetworkManagerSpy: NetworkManager {
    private(set) var requestCalledCount = 0
    private(set) var requestSent: URLRequest?

    override func sendRequest<Request: APIRequest>(_ request: Request, completion: @escaping (Result<Request.Response, APIRequestError>) -> Void) {
        requestSent = request.urlRequest
        requestCalledCount += 1
    }
}

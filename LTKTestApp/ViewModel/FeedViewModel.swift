//
//  FeedViewModel.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import SwiftUI

// Model used for item seleted from Feed
struct SelectedLTK: Codable {
    var products: [Product]?
    var profile: Profile?
    var ltk: LTK?
}

final class FeedViewModel: ObservableObject {
    typealias GetFeedResult = Result<Void, APIRequestError>
    
    // Published
    @Published private(set) var ltks: [LTK] = []
    @Published private(set) var selectedLTK: SelectedLTK = SelectedLTK()
    
    // Pagination
    private(set) var feeds: [Feed] = []
    private(set) var nextUrl: String = ""
    private(set) var feedIsFull: Bool = false
    
    // URL components
    private let getFeedPath: String = "ltks/"
    private let featuredQueryItemName: String = "featured"
    private let limitQueryItemName: String = "limit"
    
    func getFeed(limit: Int = 20, completion: @escaping (GetFeedResult) -> Void) {
        // TODO: Refactor to a URL Builder and/or Protocol; Used method below for time
        guard let baseUrl = Config.baseURL.toUrl() else { return }
        let getFeedUrl = baseUrl.appendingPathComponent(getFeedPath)
                                .appending(featuredQueryItemName, value: true.description)
                                .appending(limitQueryItemName, value: "\(limit)")
        
        let request = RequestManager<Feed>(getFeedUrl)
        NetworkManager.shared.sendRequest(request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let feed):
                // API call is a bit quick so 2.0 delay is used to show pagination
                // Would normally call `DispatchQueue.main.async { code }`
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.feeds.append(feed)
                    self.ltks.append(contentsOf: feed.ltks ?? [])
                    self.nextUrl = feed.meta?.nextUrl ?? ""
                    if self.nextUrl.isEmpty {
                        self.feedIsFull = true
                    }
                    completion(.success)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setSelectedItem(ltk: LTK) {
        // Find the feed the LTK is in
        let feed = feeds.first { feed in
            feed.ltks?.contains(where: { $0.id == ltk.id }) ?? false
        }
        
        // Find the profile and products associated with the LTK
        let profile = feed?.profiles?.first(where: { $0.id == ltk.profileId })
        let products = feed?.products?.filter({ $0.ltkId == ltk.id })
        
        // Set seletedLTK for use around application
        selectedLTK = SelectedLTK(products: products,
                                    profile: profile,
                                    ltk: ltk)
    }
}

// TODO: - Move this to own file
extension URL {
    // URLQueryItem Builder
    func appending(_ queryItemName: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else {
            return absoluteURL
        }
        
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        
        let queryItem: URLQueryItem = URLQueryItem(name: queryItemName, value: value)
        queryItems.append(queryItem)
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            fatalError("No url available")
        }
        
        return url
    }
}

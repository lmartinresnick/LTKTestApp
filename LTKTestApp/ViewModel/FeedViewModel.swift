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

/*
 We would like for you to complete a small project and demonstration so that we can get a feel for your skills and how you will gel with our team. I’ll briefly describe the project requirements, then the process that you should follow to submit your work to us, and then how the demonstration will go. Please do not spend more than two or three hours on this project, it is ok if you do not finish because this is meant to be a challenge. We’re more interested in your process and the efficacy of the code that you do write than the amount of features that you complete.

 Requirements
 Build a feed of full-width images that are consumed from a production API. A. All of our images are in an aspect ratio that supports an edge-to-edge (full-width) UI. So, no worries there. B. The feed should support pagination.
 When a user taps on one of the full-width images, then a detail view should be pushed onto the view stack. The detail view should contain product images, the hero image, and the profile picture. A. All of this information is returned from the API. To relate the different models together (ltk, product, and profile), take a look at the JSON that is returned. There are top-level lists for each of these. The ltk has a list of associated product_ids and an associated profile_id.
 When a user taps on one of the product images, then the associated  should resolve in a WebView (either in safari or in the app itself).
 To power the above requirements, you’ll consume the following public API: https://api-gateway.rewardstyle.com/api/ltk/v2/ltks/?featured=true&limit=20
 Guidelines
 Feel free to create your own project and not use the empty one attached to this task.

 You can use any resources that you would normally use in your day-to-day coding You can also use any third-party libraries that you like

 Submission
 Uplaod a zip ofthe file to this site and/or make it publically avaliable on Github and email a link to us.

 Demo
 You’ll meet with a panel of engineers who will have reviewed your project, and will have lots of questions for you about it. But, before the panel begins questioning, we would like for you to spend about 20 minutes presenting the reasoning behind your programming choices and just generally talking about your code.
 */

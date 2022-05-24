//
//  LTKTestAppApp.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import SwiftUI
import SwiftySwiftUI

@main
struct LTKTestAppApp: App {
    
    @StateObject var feedVM = FeedViewModel()
    
    init() {
        // Documentation found in Apple's `Develop in Swift Data Collections`
        // Way to hold larger amounts of image data in cache to avoid redundant API calls
        let temporaryDirectory = NSTemporaryDirectory()
        let urlCache = URLCache(memoryCapacity: 25_000_000,
                                diskCapacity: 50_000_000,
                                diskPath: temporaryDirectory)
        URLCache.shared = urlCache
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.light)
                .environmentObject(feedVM)
        }
    }
}

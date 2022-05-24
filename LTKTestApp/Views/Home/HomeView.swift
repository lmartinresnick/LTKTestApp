//
//  HomeView.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import SwiftUI
import SwiftySwiftUI
import Kingfisher

// MARK: - Controls

private struct HomeViewControls {
    var navigateToDetailView: Bool = false
    var isLoadingAPI: Bool = true
    var showAPIErrorMessage: Bool = false
}

struct HomeView: View {
    
    // MARK: - Private properities
    
    @State private var controls = HomeViewControls()
    @EnvironmentObject private var feedVM: FeedViewModel
    
    // MARK: - Main body
    var body: some View {
        ScrollView {
            // `LazyVStack` is intentional for loading content instead of `VStack`
            LazyVStack {
                ForEach(feedVM.ltks, id: \.id) { ltk in
                    feedCell(with: ltk)
                }
                
                // Condition to check if final items shown
                if !feedVM.feedIsFull {
                    // View to show when fetching next items
                    ProgressView()
                        .onAppear(perform: onAppearAction)
                        .defaultTopPadding()
                }
            }
            .showErrorViewIfNeeded(state: controls.showAPIErrorMessage, with: LocalizedStringKey("homeView.apiError.message"))
            .defaultVerticalPadding()
        }
        .navigationTitle(LocalizedStringKey("homeView.navigationTitle"))
        .embedInNavigationView()
    }
}

// MARK: - Private views

extension HomeView {
    private func feedCell(with ltk: LTK) -> some View {
        NavigationButton {
            feedVM.setSelectedItem(ltk: ltk)
        } destination: {
            DetailView(selectedLTK: feedVM.selectedLTK)
        } label: {
            KFImage(ltk.convertHeroImageToUrl())
                .basicKFModifiers()
                .scaledToFit()
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Private methods

extension HomeView {
    // OnAppearAction
    private func onAppearAction() {
        getFeed()
    }
    
    // Api call to get feed
    private func getFeed() {
        feedVM.getFeed { result in
            controls.isLoadingAPI = false
            guard case .failure = result else {
                return
            }
            
            controls.showAPIErrorMessage = true
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

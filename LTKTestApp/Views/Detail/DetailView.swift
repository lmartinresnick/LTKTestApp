//
//  DetailView.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import Kingfisher
import SwiftUI

struct DetailView: View {
    // Selected LTK shown
    var selectedLTK: SelectedLTK
    
    var body: some View {
        ScrollView {
            // `LazyVStack` intentional for loading content instead of `VStack`
            LazyVStack(spacing: 0) {
                // Hero Image with Kingfisher
                KFImage(selectedLTK.ltk?.convertHeroImageToUrl())
                    .basicKFModifiers()
                    .scaledToFit()
                    .customShadow()
                    .padding(.bottom, 30)
                // Content Divider
                shopDivider
                // Grid for linked products
                productGrid
                    .padding(.bottom)
                // Profile
                profileSection
            }
            .defaultHorizontalPadding()
            .defaultBottomPadding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    // Profile
                    principalToolbarItemContent
                }
            }
        }
    }
}

// MARK: - Private views

extension DetailView {
    private var principalToolbarItemContent: some View {
        HStack {
            profileImage(with: 40)
            Text(selectedLTK.profile?.displayName ?? "")
                .font(.headline)
        }
    }
    
    private var shopDivider: some View {
        ZStack {
            Divider()
            Text(LocalizedStringKey("detailView.shopThePic.text"))
                .textCase(.uppercase)
                .font(.subheadline)
                .padding()
                .background(Color.white)
        }
        .padding(.bottom, 20)
    }
    
    private var productGrid: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey("detailView.shopExactProducts.text"))
                .font(.caption)
            PrimaryGridView {
                ForEach(selectedLTK.products ?? [], id: \.id) { product in
                    ProductImageCellView(for: product)
                }
            }
        }
    }
    
    private func profileImage(with dimensions: CGFloat) -> some View {
        KFImage(selectedLTK.profile?.convertAvatarUrlToUrl())
            .basicKFModifiers()
            .scaledToFit()
            .frame(dimensions)
            .clipShape(Circle())
    }
    
    private var profileSection: some View {
        VStack(spacing: 15) {
            profileImage(with: 75)
            Text(selectedLTK.profile?.displayName ?? "")
                .font(.body)
                .fontWeight(.light)
            Divider()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedLTK: SelectedLTK())
    }
}

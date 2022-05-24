//
//  PrimaryGridView.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import SwiftUI

struct PrimaryGridView<Content: View>: View {
    
    let content: () -> Content
    private let gridItems: [GridItem] = [GridItem(.flexible(), spacing: 4, alignment: Alignment(horizontal: .center, vertical: .top)),
                                         GridItem(.flexible(), spacing: 4, alignment: Alignment(horizontal: .center, vertical: .top)),
                                         GridItem(.flexible(), spacing: 4, alignment: Alignment(horizontal: .center, vertical: .top)),
                                         GridItem(.flexible(), alignment: Alignment(horizontal: .center, vertical: .top))]
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 4) {
            content()
        }
    }
}

struct PrimaryGrid_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryGridView {
            ForEach(0..<5) { _ in
                Rectangle()
                    .frame(height: 100)
            }
        }
    }
}


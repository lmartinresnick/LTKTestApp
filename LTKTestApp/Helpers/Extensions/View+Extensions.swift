//
//  View+Extensions.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import SwiftUI

extension View {
    func customShadow() -> some View {
        self
            .shadow(color: Color.black.opacity(0.15), radius: 1, x: 0, y: 1)
    }
    
    func defaultHorizontalPadding() -> some View {
        self
            .padding(.horizontal)
    }
    
    func defaultVerticalPadding() -> some View {
        self
            .defaultTopPadding()
            .defaultBottomPadding()
    }
    
    func defaultTopPadding() -> some View {
        self
            .padding(.top, 20)
    }
    
    func defaultBottomPadding() -> some View {
        self
            .padding(.bottom, 50)
    }
    
    @ViewBuilder
    func showErrorViewIfNeeded(state showError: Bool, with message: LocalizedStringKey) -> some View {
        if showError {
            Text(message)
                .font(.body)
                .bold()
        } else {
            self
        }
    }
}

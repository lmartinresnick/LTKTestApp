//
//  NavigationButton.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import SwiftUI
import SwiftySwiftUI

private struct NavigationButtonControls {
    var isActive: Bool = false
}

struct NavigationButton<Destination: View, Label: View>: View {
    @State private var controls = NavigationButtonControls()
    
    var action: (() -> Void)? = nil
    var destination: () -> Destination
    var label: () -> Label
    
    var body: some View {
        Button(action: buttonAction) {
            label()
                .background(
                    ScrollView { // Fixes a bug where the navigation bar may become hidden on the pushed view
                        NavigationLink(destination: LazyDestination { destination() },
                                       isActive: $controls.isActive) { EmptyView() }
                    }
                )
        }
    }
    
    // MARK: - Private methods
    
    private func buttonAction() {
        HapticFeedbackGenerator.impactOccurred()
        action?()
        controls.isActive.toggle()
    }
}

// This view lets us avoid instantiating our Destination before it has been pushed.
struct LazyDestination<Destination: View>: View {
    var destination: () -> Destination
    var body: some View {
        destination()
    }
}

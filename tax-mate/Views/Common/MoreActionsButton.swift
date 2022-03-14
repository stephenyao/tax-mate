//
//  MoreActionsButton.swift
//  tax-mate
//
//  Created by Stephen Yao on 14/3/22.
//

import SwiftUI

struct MoreActionsButton<Content: View>: View {
    @State private var isActive: Bool = false
    private let actions: () -> Content
    
    init(@ViewBuilder actions: @escaping () -> Content) {
        self.actions = actions
    }
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Image(systemName: "ellipsis")
        }
        .confirmationDialog("Actions", isPresented: $isActive, actions: actions)
    }
}

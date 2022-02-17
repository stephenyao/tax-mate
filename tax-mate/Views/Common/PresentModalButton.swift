//
//  PresentModalButton.swift
//  tax-mate
//
//  Created by Stephen Yao on 17/2/22.
//

import SwiftUI

struct PresentModalButton<Content: View>: View {
    @Binding var showNewItem: Bool
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        Button(action: {
            self.showNewItem.toggle()
        }, label: {
            Image(systemName: "plus")
        })
        .frame(width: 44, height: 44)
        .sheet(isPresented: $showNewItem, content: self.content)
    }
}

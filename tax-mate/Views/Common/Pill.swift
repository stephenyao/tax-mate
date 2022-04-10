//
//  Pill.swift
//  tax-mate
//
//  Created by Stephen Yao on 10/4/2022.
//

import Foundation
import SwiftUI

struct Pill<Content: View>: View {
    var selected = false
    var action: () -> Void
    @ViewBuilder var label: () -> Content
    
    private var background: Color {
        Color(UIColor.systemGray6)
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: label)
            .padding([.leading, .trailing])
            .frame(height: 38)
            .background(self.selected ? Color(UIColor.systemBlue) : background)
            .foregroundColor(self.selected ? .white : Color(UIColor.systemBlue))
            .cornerRadius(22.0)
    }
}

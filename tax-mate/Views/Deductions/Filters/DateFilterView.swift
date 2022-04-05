//
//  DateFilterView.swift
//  tax-mate
//
//  Created by Stephen Yao on 4/4/22.
//

import SwiftUI

enum DateFilterOption: String, CaseIterable {
    case all = "All time"
    case last30 = "Last 30"
    case last90 = "Last 90"
    case custom = "Custom Range"
}

struct DateFilterView: View {
    @Binding var selected: DateFilterOption

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(DateFilterOption.allCases, id: \.rawValue) { option in
                    Pill(selected: self.selected == option, action: { self.selected = option }, label: { Text(option.rawValue) })
                }
            }
            .font(.footnote)
        }
    }
}

private struct Pill<Content: View>: View {
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

struct Previews_DateFilterVieww_Previews: PreviewProvider {
    static var previews: some View {        
        DateFilterView(selected: .constant(.all)).preferredColorScheme(.dark)
    }
}

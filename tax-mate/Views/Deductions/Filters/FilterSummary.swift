//
//  FilterSummary.swift
//  tax-mate
//
//  Created by Stephen Yao on 5/4/22.
//

import SwiftUI

struct DeductionsFilterSummary: View {
    let selectionOption: DateFilterOption
    
    private var backgroundColor: Color {
        Color(UIColor.systemGray6)
    }
    
    var body: some View {
        HStack {
            Text("Showing: \(selectionOption.rawValue)")
                .font(.footnote)
                .fontWeight(.semibold)
            Image(systemName: "chevron.right")
        }
        .padding()
        .frame(height: 38)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerSize: CGSize(width: 11, height: 11)).foregroundColor(backgroundColor))
    }
}

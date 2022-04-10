//
//  FilterSummary.swift
//  tax-mate
//
//  Created by Stephen Yao on 5/4/22.
//

import SwiftUI

struct DeductionsFilterSummary: View {
    let data: DateFilterData
    
    private var backgroundColor: Color {
        Color(UIColor.systemGray6)
    }
    
    private var filterSummaryText: String {
        switch data.selectedOption {
            case .custom: return data.dateRangeText
            default: return data.selectedOption.rawValue
        }
    }
    
    var body: some View {
        HStack {
            Text("Showing: \(filterSummaryText)")
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

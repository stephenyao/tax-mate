//
//  DeductionsFilterView.swift
//  tax-mate
//
//  Created by Stephen Yao on 1/4/22.
//

import Foundation
import SwiftUI

struct DeductionsFilterView: View {
    private var backgroundColor: Color {
        Color(UIColor.systemGray6)
    }
    
    var body: some View {
        HStack {
            Text("Showing: All time")
                .font(.footnote)
                .fontWeight(.semibold)
            Image(systemName: "chevron.down")
        }
        .padding()
        .frame(height: 38)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerSize: CGSize(width: 11, height: 11)).foregroundColor(backgroundColor))
        
    }
}

struct Previews_Deductions_Filter_View: PreviewProvider {
    static var previews: some View {
        DeductionsFilterView().preferredColorScheme(.light)
        DeductionsFilterView().preferredColorScheme(.dark)
    }
}

//
//  DeductionsFilterView.swift
//  tax-mate
//
//  Created by Stephen Yao on 1/4/22.
//

import Foundation
import SwiftUI
import Combine

struct DeductionsFilterView: View {
    @Binding var selectedOption: DateFilterOption
    @State private var showsFilters = false
    
    var body: some View {
        Group {
            if !showsFilters {
                DeductionsFilterSummary(selectionOption: selectedOption)
                    .onTapGesture {
                        withAnimation {
                            self.showsFilters = true
                        }
                    }
            } else {
                DateFilterView(selected: $selectedOption)
            }
        }
        .onChange(of: selectedOption) { newValue in
            withAnimation {
                self.showsFilters = false
            }
        }
    }
}

struct Previews_Deductions_Filter_View: PreviewProvider {
    static var previews: some View {
        DeductionsFilterView(selectedOption: .constant(.all)).preferredColorScheme(.light)
        DeductionsFilterView(selectedOption: .constant(.all)).preferredColorScheme(.dark)
    }
}

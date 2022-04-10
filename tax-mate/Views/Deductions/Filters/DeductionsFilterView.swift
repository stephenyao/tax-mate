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
    @Binding var dateFilter: DateFilterData
    @State private var showsFilters = false
    
    var body: some View {
        Group {
            if !showsFilters {
                DeductionsFilterSummary(data: dateFilter)
                    .onTapGesture {
                        withAnimation {
                            self.showsFilters = true
                        }
                    }
            } else {
                DateFilterView(data: $dateFilter)
            }
        }
        .onChange(of: dateFilter.selectedOption) { newValue in
            withAnimation {
                self.showsFilters = false
            }
        }
    }
}

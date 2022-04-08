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
                DeductionsFilterSummary(selectionOption: self.dateFilter.selectedOption)
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

//struct Previews_Deductions_Filter_View: PreviewProvider {
//    static var previews: some View {
//        DeductionsFilterView(selectedOption: .constant(.all)).preferredColorScheme(.light)
//        DeductionsFilterView(selectedOption: .constant(.all)).preferredColorScheme(.dark)
//    }
//}

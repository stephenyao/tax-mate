//
//  DateFilterView.swift
//  tax-mate
//
//  Created by Stephen Yao on 4/4/22.
//

import SwiftUI

struct DateFilterView: View {
    @Binding var data: DateFilterData
    @Binding var showsFilters: Bool
    @State var presentDatePicker = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(DateFilterData.Option.allCases, id: \.rawValue) { option in
                    switch option {
                        case .custom:
                            Pill(selected: self.data.selectedOption == .custom) {
                                self.presentDatePicker = true
                            } label: {
                                Text(option.rawValue)
                            }
                        default:
                            Pill(selected: self.data.selectedOption == option, action: {
                                withAnimation {
                                    self.data.selectedOption = option                               
                                    self.showsFilters = false
                                }
                            }, label: { Text(option.rawValue) })
                    }
                }
            }
            .font(.footnote)
        }
        .bottomSheet(isPresented: $presentDatePicker) {
            DateRangeSelector(dateFilter: $data, isPresented: $presentDatePicker, showsFilters: $showsFilters)
        }
    }
}

struct DummyFilterView: View {
    @State private var filterData = DateFilterData(selectedOption: .all)
    @State private var showsFilters = true
    var body: some View {
        DateFilterView(data: $filterData, showsFilters: $showsFilters)
    }
}

struct Previews_DateFilterVieww_Previews: PreviewProvider {
    static var previews: some View {
        DummyFilterView()
    }
}

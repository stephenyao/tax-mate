//
//  DateFilterView.swift
//  tax-mate
//
//  Created by Stephen Yao on 4/4/22.
//

import SwiftUI

struct DateFilterView: View {
    @Binding var data: DateFilterData
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
                            Pill(selected: self.data.selectedOption == option, action: { self.data.selectedOption = option }, label: { Text(option.rawValue) })
                    }
                }
            }
            .font(.footnote)
        }
        .bottomSheet(isPresented: $presentDatePicker) {
            DateRangeSelector(dateFilter: $data, isPresented: $presentDatePicker)
        }
    }
}

struct DummyFilterView: View {
    @State private var filterData = DateFilterData(selectedOption: .all)
    var body: some View {
        DateFilterView(data: $filterData)
    }
}

struct Previews_DateFilterVieww_Previews: PreviewProvider {
    static var previews: some View {
        DummyFilterView()
    }
}

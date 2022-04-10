//
//  DateRangeSelector.swift
//  tax-mate
//
//  Created by Stephen Yao on 10/4/2022.
//

import Foundation
import SwiftUI

struct DateRangeSelector: View {
    @Binding var dateFilter: DateFilterData
    @Binding var isPresented: Bool
    @State var from: Date = .init(timeIntervalSinceReferenceDate: 0)
    @State var to: Date = .now
    
    var body: some View {
        VStack {
            DatePicker("From", selection: $from, displayedComponents: .date)
            DatePicker("To", selection: $to, displayedComponents: .date)
            Button(action: {
                self.dateFilter.selectedOption = .custom
                self.dateFilter.from = from
                self.dateFilter.to = to
                self.isPresented = false
            }) {
                Text("Apply")
            }
        }
        .padding()
    }
}


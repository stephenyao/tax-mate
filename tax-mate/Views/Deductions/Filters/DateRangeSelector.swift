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
    @Binding var showsFilters: Bool
    @State var from: Date = .init(timeIntervalSinceReferenceDate: 0)
    @State var to: Date = .now

    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 8)
            Text("Select Date Range")
                .font(.body)
                .fontWeight(.semibold)
            DatePicker("From", selection: $from, displayedComponents: .date)
            DatePicker("To", selection: $to, displayedComponents: .date)
            Spacer()
            Button(action: {
                withAnimation {
                    self.dateFilter.selectedOption = .custom
                    self.dateFilter.from = from
                    self.dateFilter.to = to
                    self.isPresented = false
                    self.showsFilters = false
                }
            }) {
                Text("Apply")
                    .frame(maxWidth: .infinity)
                    .frame(height: 34)
            }
            .buttonStyle(.borderedProminent)
            .padding([.bottom])
        }
        .padding()
        .onAppear {
            if self.dateFilter.selectedOption == .custom {
                self.from = self.dateFilter.from
                self.to = self.dateFilter.to
            }
        }
    }
}

struct Previews_DateRangeSelector_Previews: PreviewProvider {
    static var previews: some View {
        DateRangeSelector(dateFilter: .constant(DateFilterData(selectedOption: .custom)), isPresented: .constant(true), showsFilters: .constant(true))
            .frame(height: 250)
    }
}

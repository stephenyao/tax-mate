//
//  DateFilterView.swift
//  tax-mate
//
//  Created by Stephen Yao on 4/4/22.
//

import SwiftUI

struct DateFilterData {
    enum Option: String, CaseIterable {
        case all = "All time"
        case last30 = "Last 30"
        case last90 = "Last 90"
        case custom = "Custom Range"
    }
    
    var from: Date = .init(timeIntervalSinceReferenceDate: 0)
    var to: Date = .now
    
    var dateRangeText: String {
        return
            """
             \(formatter.string(from: from)) - \(formatter.string(from: to))
            """
    }
    
    private var formatter: DateFormatter {
       let f = DateFormatter()
        f.dateStyle = .medium
        return f
    }
    
    var selectedOption: Option {
        didSet {
            switch selectedOption {
                case .all:
                    self.from = .init(timeIntervalSinceReferenceDate: 0)
                    self.to = .now
                case .last30:
                    self.from = .init(timeIntervalSinceNow: -30 * 24 * 3600)
                    self.to = .now
                case .last90:
                    self.from = .init(timeIntervalSinceNow: -30 * 24 * 3600)
                    self.to = .now
                default: break
            }
        }
    }
}

struct DateFilterView: View {
    @Binding var data: DateFilterData
    @State var presentDatePicker = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(DateFilterData.Option.allCases, id: \.rawValue) { option in
                    switch option {
                        case .custom:
                            Pill(selected: self.data.selectedOption == option) {
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
            VStack {
                DatePicker("From", selection: $data.from, displayedComponents: .date)
                DatePicker("To", selection: $data.to, displayedComponents: .date)
                Button(action: {
                    self.data.selectedOption = .custom
                    self.presentDatePicker = false
                }) {
                    Text("Apply")
                }
            }
            .padding()
        }
    }
}

private struct Pill<Content: View>: View {
    var selected = false
    var action: () -> Void
    @ViewBuilder var label: () -> Content
    
    private var background: Color {
        Color(UIColor.systemGray6)
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: label)
            .padding([.leading, .trailing])
            .frame(height: 38)
            .background(self.selected ? Color(UIColor.systemBlue) : background)
            .foregroundColor(self.selected ? .white : Color(UIColor.systemBlue))
            .cornerRadius(22.0)
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

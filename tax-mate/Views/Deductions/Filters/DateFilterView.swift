//
//  DateFilterView.swift
//  tax-mate
//
//  Created by Stephen Yao on 4/4/22.
//

import SwiftUI

enum DateFilterOption: String, CaseIterable {
    case all = "All time"
    case last30 = "Last 30"
    case last90 = "Last 90"
    case custom = "Custom Range"
}

struct DateFilterData {
    var from: Date?
    var to: Date?
    
    var selectedOption: DateFilterOption {
        didSet {
            switch selectedOption {
                case .all:
                    self.from = nil
                    self.to = nil
                case .last30:
                    self.from = .init(timeIntervalSinceNow: -30 * 24 * 3600)
                    self.to = nil
                case .last90:
                    self.from = .init(timeIntervalSinceNow: -30 * 24 * 3600)
                    self.to = nil
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
                ForEach(DateFilterOption.allCases, id: \.rawValue) { option in
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
            Text("Dates")
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

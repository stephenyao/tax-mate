//
//  DateFilter.swift
//  tax-mate
//
//  Created by Stephen Yao on 10/4/2022.
//

import Foundation

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

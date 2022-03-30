//
//  DeductionGroup.swift
//  tax-mate
//
//  Created by Stephen Yao on 26/3/22.
//

import Foundation

struct DeductionsGroup {
    let date: Date
    let deductions: [Deduction]    
    
    static func groups(from deductions: [Deduction]) -> [DeductionsGroup] {
        return group(deductions: deductions)
    }
}

private func group(deductions: [Deduction]) -> [DeductionsGroup] {
    var dateMap: [Date: [Deduction]] = [:]
    
    for deduction in deductions {
        let normalisedDate = startOfDay(for: deduction.date)
        if let _ = dateMap[normalisedDate] {
            dateMap[normalisedDate]!.append(deduction)
        } else {
            dateMap[normalisedDate] = [deduction]
        }
    }
    
    return dateMap.map { (key: Date, value: [Deduction]) in
        DeductionsGroup(date: key, deductions: value)
    }.sorted { $0.date > $1.date }
}

private func startOfDay(for date: Date) -> Date {
    let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
    return Calendar.current.date(from: components)!
}

//
//  Date.swift
//  tax-mate
//
//  Created by Stephen Yao on 15/4/2022.
//

import Foundation

extension Date {
    func startOfDay() -> Date {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: self)
        return Calendar.current.date(from: components)!
    }        
}

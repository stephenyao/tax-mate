//
//  Formatter.swift
//  tax-mate
//
//  Created by Stephen Yao on 15/4/2022.
//

import Foundation

final class Formatter {
    static let sharedInstance = Formatter()
    
    lazy var mediumDate: DateFormatter = {
       let f = DateFormatter()
        f.dateStyle = .medium
        return f
    }()
}

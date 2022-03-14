//
//  Deduction.swift
//  tax-mate
//
//  Created by Stephen Yao on 17/2/22.
//

import Foundation
import UIKit

struct Deduction {
    let identifier: String
    let name: String
    let date: Date
    let image: UIImage?
    let cost: Double
    
    init(
        identifier: String = UUID().uuidString,
        name: String,
        date: Date,
        image: UIImage?,
        cost: Double
    ) {
        self.identifier = identifier
        self.name = name
        self.date = date
        self.image = image
        self.cost = cost
    }
}

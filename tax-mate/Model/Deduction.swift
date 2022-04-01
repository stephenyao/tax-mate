//
//  Deduction.swift
//  tax-mate
//
//  Created by Stephen Yao on 17/2/22.
//

import Foundation
import UIKit

struct Deduction: Identifiable {
    let id: String    
    let name: String
    let date: Date
    let image: UIImage?
    let cost: Double
    
    init(
        id: String = UUID().uuidString,
        name: String,
        date: Date,
        image: UIImage?,
        cost: Double
    ) {
        self.id = id
        self.name = name
        self.date = date
        self.image = image
        self.cost = cost
    }
}

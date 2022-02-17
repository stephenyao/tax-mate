//
//  Deduction.swift
//  tax-mate
//
//  Created by Stephen Yao on 17/2/22.
//

import Foundation
import UIKit

struct Deduction {
    let identifier: String = UUID().uuidString
    let name: String
    let date: Date
    let image: UIImage?
    let cost: Double
}

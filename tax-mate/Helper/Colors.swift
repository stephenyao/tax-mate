//
//  Colors.swift
//  tax-mate
//
//  Created by Stephen Yao on 30/3/22.
//

import Foundation
import SwiftUI

extension Color {
    static var theme: Color {
        Color("theme-color")
    }
    
    static var formBackground: Color {
        Color(uiColor: .systemGray6)
    }
    
    static var standardBackground: Color {
        Color("background")
    }
}

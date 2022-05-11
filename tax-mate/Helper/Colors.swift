//
//  Colors.swift
//  tax-mate
//
//  Created by Stephen Yao on 30/3/22.
//

import Foundation
import SwiftUI

// Pallete at: https://coolors.co/b24c63-5438dc-0f52bd-56eef4-32e875

extension Color {
    static var theme: Color {
        Color("theme-color")
    }
    
    static var themeBackground: Color {
        Color("theme-bg")
    }
    
    static var formBackground: Color {
        Color(uiColor: .systemGray6)
    }
    
    static var standardBackground: Color {
        Color("background")
    }
}

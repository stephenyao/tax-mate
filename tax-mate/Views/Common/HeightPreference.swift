//
//  HeightPreference.swift
//  tax-mate
//
//  Created by Stephen Yao on 11/5/2022.
//

import SwiftUI

struct HeightPreference: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

//
//  CloseButton.swift
//  tax-mate
//
//  Created by Stephen Yao on 14/4/2022.
//

import SwiftUI

struct CloseButton: View {
    @Binding var showsModal: Bool
    
    var body: some View {
        Button(action: {
            self.showsModal = false
        }, label: {
            Text("Cancel")
        })
        .frame(width: 44, height: 44)
    }
}

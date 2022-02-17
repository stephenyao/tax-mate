//
//  AddDeductionsView.swift
//  tax-mate
//
//  Created by Stephen Yao on 17/2/22.
//

import SwiftUI

struct AddDeductionsView: View {
    @State var name: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Name")
                    Spacer()
                    TextField("Name", text: $name)
                        .textContentType(.name)
                }                                
            }
        }
    }
}

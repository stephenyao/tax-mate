//
//  FormInput.swift
//  tax-mate
//
//  Created by Stephen Yao on 14/4/2022.
//

import SwiftUI

struct FormInputText: View {
    @Binding var text: String
    let inputTitle: String
    
    var body: some View {
        TextField(inputTitle, text: $text)
            .padding()
            .multilineTextAlignment(.leading)
            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.formBackground))
    }
}

struct FormInput_Previews: PreviewProvider {
    static var previews: some View {
        FormInputText(text: .constant("D1"), inputTitle: "Name")
            .padding()
    }
}

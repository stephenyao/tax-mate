//
//  FormInput.swift
//  tax-mate
//
//  Created by Stephen Yao on 14/4/2022.
//

import SwiftUI

struct FormInputCurrencyRow: View {
    @Binding var amount: Double?
    let inputTitle: String
    
    var body: some View {
        TextField(inputTitle, value: $amount, format: .currency(code: Locale.current.currencyCode ?? "AUD"))
            .keyboardType(.decimalPad)
            .padding()
            .multilineTextAlignment(.leading)
            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color(uiColor: .systemGray6)))
    }
}

private struct Preview: View {
    @State private var amount: Double?
    @FocusState private var isActive: Bool
    
    var body: some View {
        FormInputCurrencyRow(amount: $amount, inputTitle: "$0.00")
            .focused($isActive)
    }
}

struct FormInputCurrencyRow_Preview: PreviewProvider {
    static var previews: some View {
        Preview().padding()
    }
}

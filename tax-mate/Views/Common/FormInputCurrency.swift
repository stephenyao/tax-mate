//
//  FormInput.swift
//  tax-mate
//
//  Created by Stephen Yao on 14/4/2022.
//

import SwiftUI

struct FormInputCurrencyRow: View {
    let inputTitle: String
    @Binding var amount: Double?
    var isActive: FocusState<Bool>.Binding
    
    var body: some View {
        TextField(inputTitle, value: $amount, format: .currency(code: Locale.current.currencyCode ?? "AUD"))
            .keyboardType(.decimalPad)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        self.isActive.wrappedValue = false
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.leading)
            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color(uiColor: .systemGray6)))
    }
}

private struct Preview: View {
    @State private var amount: Double?
    @FocusState private var isActive: Bool
    
    var body: some View {
        FormInputCurrencyRow(inputTitle: "$0.00", amount: $amount, isActive: $isActive)
            .focused($isActive)
    }
}

struct FormInputCurrencyRow_Preview: PreviewProvider {
    static var previews: some View {
        Preview().padding()
    }
}

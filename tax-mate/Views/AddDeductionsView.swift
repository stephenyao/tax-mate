//
//  AddDeductionsView.swift
//  tax-mate
//
//  Created by Stephen Yao on 17/2/22.
//

import SwiftUI

struct AddDeductionsView: View {
    @State private var name: String = ""
    @State private var date: Date = .now.startOfDay()
    @State private var image: UIImage?
    @State private var money: Double?
    @FocusState private var focus: Bool
    private let repository = DeductionsRepository()
    @StateObject private var viewModel = AddDeductionsViewModel()
    
    @Binding var showsModal: Bool
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    ImagePickerButton(image: $viewModel.image) {
                        focus = false
                    }
                    Spacer().frame(height: 14)
                    FormInputRow(text: $viewModel.name, inputTitle: "Name")
                        .focused($focus)
                    FormInputCurrencyRow(inputTitle: "$0.00", amount: $viewModel.cost, isActive: $focus)
                        .focused($focus)
                    FormInputDateRow(date: $viewModel.date, inputTitle: "Date")
                }
                .padding()
            }
            .navigationTitle("New Deduction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CloseButton(showsModal: $showsModal)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.save()
                        showsModal = false
                    }
                    .disabled(!viewModel.inputValid)
                }
            }
        }
    }
}

struct AddDeductionsView_Previews: PreviewProvider {
    static var previews: some View {
        AddDeductionsView(showsModal: .constant(true))
    }
}

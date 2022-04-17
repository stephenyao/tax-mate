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
    @State private var presentDatePicker = false
    @FocusState private var focus: Bool
    private let repository = DeductionsRepository()
    @StateObject private var viewModel = AddDeductionsViewModel()
    
    @Binding var showsModal: Bool
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    Group {
                        ImagePickerButton(image: $viewModel.image)
                        Spacer().frame(height: 14)
                        FormInputText(text: $viewModel.name, inputTitle: "Name")
                            .focused($focus)
                        FormInputCurrency(amount: $viewModel.cost, inputTitle: "$0.00")
                            .focused($focus)
                        FormInputDate(date: $viewModel.date, inputTitle: "Date", presentPicker: $presentDatePicker)
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            focus = false
                        }
                    )
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                focus = false
                            }
                        }
                    }
                    .onChange(of: focus) { newValue in
                        if newValue == true {
                            withAnimation {
                                presentDatePicker = false
                            }
                        }
                    }
                }
                .padding()
                .background(.black)
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

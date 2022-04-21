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
    @State private var cost: Double?
    @State private var presentDatePicker = false
    @FocusState private var focus: Bool
    private let repository = DeductionsRepository()
    @StateObject private var viewModel = AddDeductionsViewModel()
    
    @Binding var showsModal: Bool
    
    @ViewBuilder private var imagePicker: some View {
        ImagePickerButton(image: $viewModel.image)
            .simultaneousGesture(
                TapGesture().onEnded {
                    focus = false
                }
            )
    }
    
    @ViewBuilder private var nameInput: some View {
        FormInputText(text: $viewModel.name, inputTitle: "Name")
            .focused($focus)
    }
    
    @ViewBuilder private var costInput: some View {
        FormInputCurrency(amount: $viewModel.cost, inputTitle: "$0.00")
            .focused($focus)
    }
    
    @ViewBuilder private var datePicker: some View {
        FormInputDate(date: $viewModel.date, inputTitle: "Date", presentPicker: $presentDatePicker) {
            focus = false 
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    Group {
                        imagePicker
                        Spacer().frame(height: 14)
                        nameInput
                        costInput
                        datePicker
                    }
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
                .background(Color.standardBackground)
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

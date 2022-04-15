//
//  AddDeductionsView.swift
//  tax-mate
//
//  Created by Stephen Yao on 17/2/22.
//

import SwiftUI

struct AddDeductionsView: View {
    @State private var name: String = ""
    @State private var cost: String = ""
    @State private var date: Date = .now.startOfDay()
    @State private var image: UIImage?
    @FocusState private var focus: Bool
    
    private let repository = DeductionsRepository()

    @Binding var showsModal: Bool
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    ImagePickerButton(image: $image) {
                        focus = false
                    }
                    Spacer().frame(height: 14)
                    FormInputRow(text: $name, inputTitle: "Name")
                        .focused($focus)
                    FormInputRow(text: $cost, inputTitle: "Cost")
                        .focused($focus)
                    FormInputDateRow(date: $date, inputTitle: "Date")
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
                        let deduction = Deduction(name: name, date: date, image: image, cost: Double(cost) ?? 0)
                        repository.insert(deduction: deduction)
                        showsModal = false
                    }
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

//
//  AddDeductionsView.swift
//  tax-mate
//
//  Created by Stephen Yao on 17/2/22.
//

import SwiftUI

struct AddDeductionsView: View {
    @State var name: String = ""
    @State var cost: String = ""
    @State var date: Date = .now.startOfDay()
    @State var image: UIImage?
    @Binding var showsModal: Bool
    
    private let repository = DeductionsRepository()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    ImagePickerButton(image: $image)
                        .padding()
                    FormInputRow(text: $name, inputTitle: "Name")
                    FormInputRow(text: $cost, inputTitle: "Cost")
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

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
                    VStack {
                        ImagePickerButton(image: $image)                            
                    }
                    .padding()
                    FormInputRow(text: $name, inputTitle: "Name")
                    FormInputRow(text: $cost, inputTitle: "Cost")
                    FormInputDateRow(date: $date, inputTitle: "Date")
                    
                    Button {
                        let deduction = Deduction(name: name, date: date, image: image, cost: Double(cost) ?? 0)
                        repository.insert(deduction: deduction)
                        showsModal = false
                    } label: {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                    }
                    .padding([.top, .bottom])
                    .buttonStyle(.borderedProminent)
                }
                .foregroundColor(.theme)
                .padding()
                
              
            }
            .navigationTitle("New Deduction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CloseButton(showsModal: $showsModal)
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

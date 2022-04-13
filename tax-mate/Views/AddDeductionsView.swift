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
    @State var date: Date = .now
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
                    VStack {
                        HStack {
                            Text("Name")
                            Spacer()
                            TextField("Name", text: $name)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    
                    VStack {
                        HStack {
                            Text("Cost")
                            Spacer()
                            TextField("Cost", text: $cost)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    
                    VStack {
                        HStack {
                            DatePicker("Date", selection: $date, displayedComponents: .date)
                        }
                    }
                }
                .padding()
                
                Button("Save") {
                    let deduction = Deduction(name: name, date: date, image: image, cost: Double(cost) ?? 0)
                    repository.insert(deduction: deduction)
                    showsModal = false
                }
                .padding([.bottom])
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

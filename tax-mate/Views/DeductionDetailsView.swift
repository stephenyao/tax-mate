//
//  DeductionDetailsView.swift
//  tax-mate
//
//  Created by Stephen Yao on 19/2/22.
//

import SwiftUI

struct DeductionDetailsView: View {
    let deduction: Deduction
    private let repository = DeductionsRepository()
    @State var confirm = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Name")
                Spacer()
                Text(deduction.name)
            }
            
            HStack {
                Text("Cost")
                Spacer()
                Text("\(deduction.cost)")
            }
            if let image = deduction.image {
                HStack {
                    Text("Image")
                    Spacer()
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 150, height: 150)
                }
            }
        }
        .navigationBarItems(trailing: MoreActionsButton {
            Button("Delete deduction", role: .destructive) {
                confirm = true
            }
        })
        .alert("Are you sure you want to delet this deduction?", isPresented: $confirm) {
            Button("Confirm", role: .destructive) {
                print("deleting")
            }
        }
    }
}

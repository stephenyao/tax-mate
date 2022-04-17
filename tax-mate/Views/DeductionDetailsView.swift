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
    @State var presentDeleteAlert = false
    
    var body: some View {
        VStack() {
            if let image = deduction.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 250)
            }
            
            VStack {
                Text("Name")
                Text(deduction.name)
                    .fontWeight(.semibold)
            }
            
            VStack {
                Text("Cost")
                Text("\(deduction.cost)")
            }
            Spacer()
        }

        .navigationBarItems(trailing: MoreActionsButton {
            Button("Delete deduction", role: .destructive) {
                presentDeleteAlert = true
            }
        })
        .alert("Are you sure you want to delete this deduction?", isPresented: $presentDeleteAlert) {
            Button("Confirm", role: .destructive) {
                repository.delete(deduction: deduction)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

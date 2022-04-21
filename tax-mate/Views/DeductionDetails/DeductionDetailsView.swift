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
        ScrollView {
            if let image = deduction.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 250)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.theme)
                    Spacer().frame(height: 4)
                    Text(deduction.name)
                }
                Spacer()
            }
            
            Spacer().frame(height: 22)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Cost")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.theme)
                    Spacer().frame(height: 4)
                    Text("\(deduction.cost)")
                }
                Spacer()
            }
        }
        .padding()
        
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

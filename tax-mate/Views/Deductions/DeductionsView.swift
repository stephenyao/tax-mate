//
//  ContentView.swift
//  tax-mate
//
//  Created by Stephen Yao on 16/2/22.
//

import SwiftUI
import CoreData

struct DeductionsView: View {
    private let repository = DeductionsRepository()
    @State var showsAddDeductions = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(repository.fetch(), id: \.identifier) {
                    NavigationLink($0.name, destination: DeductionDetailsView(deduction: $0))
                }
            }
            .listStyle(.plain)
            .navigationTitle("Deductions")
            .navigationBarItems(trailing: PresentModalButton(showNewItem: $showsAddDeductions) {
                AddDeductionsView(showsModal: $showsAddDeductions)
            })
        }
        .navigationViewStyle(.stack)
    }
}

struct DeductionsView_Previews: PreviewProvider {
    static var previews: some View {
        DeductionsView()
    }
}

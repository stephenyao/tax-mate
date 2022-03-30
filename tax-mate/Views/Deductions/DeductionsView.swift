//
//  ContentView.swift
//  tax-mate
//
//  Created by Stephen Yao on 16/2/22.
//

import SwiftUI
import CoreData

struct DeductionsView: View {
    @StateObject private var viewModel = DeductionsViewModel(
        pagingObserver: DeductionsPagingObserver()
    )
    @State var showsAddDeductions = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.deductionsGroup, id: \.date) { group in
                    Section(header: Text(group.date.description)) {
                        ForEach(group.deductions, id: \.identifier) { deduction in
                            NavigationLink(deduction.name, destination: DeductionDetailsView(deduction: deduction))
                        }
                    }
                }
                
                if viewModel.hasNext() {                    
                    Text("Loading...")
                        .onAppear {
                            self.viewModel.loadNext()
                        }
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

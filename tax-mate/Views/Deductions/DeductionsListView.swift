//
//  DeductionsListView.swift
//  tax-mate
//
//  Created by Stephen Yao on 30/3/22.
//

import SwiftUI

struct DeductionsListView: View {
    @StateObject private var viewModel = DeductionsViewModel(
        pagingObserver: DeductionsPagingObserver()
    )
    @State private var showsAddDeductions = false
    @State private var emptySearchQuery = ""
    @Binding var isSearching: Bool
    var namespace: Namespace.ID
    
    var body: some View {
        NavigationView {
            List {
                SearchBar(query: $emptySearchQuery, isActive: $isSearching)
                    .listRowSeparator(.hidden)
                    .matchedGeometryEffect(id: "searchbar", in: namespace)
                DeductionsFilterView()
                    .listRowSeparator(.hidden)
                ForEach(viewModel.deductionsGroup, id: \.date) { group in
                    Section(header: Text(viewModel.displayString(for: group.date)).foregroundColor(.theme)) {
                        ForEach(group.deductions) { deduction in
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


private struct DummyDeductionsListView: View {
    @Namespace var namespace
    
    var body: some View {
        DeductionsListView(isSearching: .constant(false), namespace: namespace)
    }
}

struct Previews_DeductionsListView_Previews: PreviewProvider {
    static var previews: some View {
        DummyDeductionsListView().preferredColorScheme(.light)
        DummyDeductionsListView().preferredColorScheme(.dark)
    }
}

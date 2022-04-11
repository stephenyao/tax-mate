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
    
    var searchBar: some View {
        SearchBar(query: $emptySearchQuery, isActive: $isSearching)
            .listRowSeparator(.hidden)
            .matchedGeometryEffect(id: "searchbar", in: namespace)
    }
    
    var filters: some View {
        DeductionsFilterView(dateFilter: $viewModel.filterData)
            .listRowSeparator(.hidden)
    }
    
    var rows: some View {
        ForEach(viewModel.deductionsGroup, id: \.date) { group in
            Section(header: Text(viewModel.displayString(for: group.date)).foregroundColor(.theme)) {
                ForEach(group.deductions) { deduction in
                    NavigationLink(deduction.name, destination: DeductionDetailsView(deduction: deduction))
                }
            }
        }
    }
    
    var nextLoading: some View {
        Text("Loading...")
            .onAppear {
                self.viewModel.loadNext()
            }
    }
    
    var body: some View {
        NavigationView {
            List {
                searchBar
                filters
                rows                
                if viewModel.hasNext() {
                    nextLoading
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
    @State private var filter = DateFilterData(selectedOption: .all)
    @State private var searching = false
    
    var body: some View {
        DeductionsListView(isSearching: $searching, namespace: namespace)
    }
}

struct Previews_DeductionsListView_Previews: PreviewProvider {
    static var previews: some View {
        DummyDeductionsListView().preferredColorScheme(.light)
        DummyDeductionsListView().preferredColorScheme(.dark)
    }
}

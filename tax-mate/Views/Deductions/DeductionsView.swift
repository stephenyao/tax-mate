//
//  ContentView.swift
//  tax-mate
//
//  Created by Stephen Yao on 16/2/22.
//

import SwiftUI
import CoreData
import Introspect

struct SearchDeductionsView: View {
    var namespace: Namespace.ID
    @Binding var isSearching: Bool
    @State private var buttonOffset: CGFloat = 100
    
    var body: some View {
        VStack {
            HStack {
                SearchBar(isActive: $isSearching)
                    .matchedGeometryEffect(id: "searchbar", in: namespace)
                    .introspectTextField { textField in
                        textField.becomeFirstResponder()
                    }
                Button {
                    withAnimation {
                        self.isSearching = false
                        self.buttonOffset = 100
                    }
                } label: {
                    Text("cancel")
                }
                .offset(x: buttonOffset)
            }
            Spacer()
        }
        .onAppear {
            withAnimation {
                self.buttonOffset = 0
            }
        }
    }
}

struct DeductionsView: View {
    @StateObject private var viewModel = DeductionsViewModel(
        pagingObserver: DeductionsPagingObserver()
    )
    @State var showsAddDeductions = false
    @Namespace var namespace
    @State var isSearching = false
    
    var body: some View {
        //        NavigationView {
        if !isSearching {
            NavigationView {
                List {
                    SearchBar(isActive: $isSearching)
                        .listRowSeparator(.hidden)
                        .matchedGeometryEffect(id: "searchbar", in: namespace)
                    ForEach(viewModel.deductionsGroup, id: \.date) { group in
                        Section(header: Text(viewModel.displayString(for: group.date)).foregroundColor(.theme)) {
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
            .navigationViewStyle(StackNavigationViewStyle())
        } else {
            SearchDeductionsView(namespace: namespace, isSearching: $isSearching)
        }
    }
}

struct DeductionsView_Previews: PreviewProvider {
    static var previews: some View {
        DeductionsView()
    }
}

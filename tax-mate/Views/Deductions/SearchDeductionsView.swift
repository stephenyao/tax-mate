//
//  DeductionsSearchView.swift
//  tax-mate
//
//  Created by Stephen Yao on 30/3/22.
//

import SwiftUI
import Introspect

struct SearchDeductionsView: View {
    var namespace: Namespace.ID
    @Binding var isSearching: Bool
    @State private var buttonOffset: CGFloat = 100
    @StateObject private var viewModel = SearchDeductionsViewModel()
    @State private var hidesNavBar = false
    @State private var presentsModal = false
    @State private var selectedDeduction: Deduction?
    
    var body: some View {
        VStack {
            HStack {
                SearchBar(query: $viewModel.searchQuery, isActive: $isSearching)
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
            .padding()
            List {
                ForEach(viewModel.searchResults) { deduction in
                    Text(deduction.name)
                        .onTapGesture {
                            self.selectedDeduction = deduction
                        }
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("test")
        .onAppear {
            withAnimation {
                self.buttonOffset = 0
            }
        }
        .sheet(item: self.$selectedDeduction) { deduction in
            DeductionDetailsView(deduction: deduction)
        }
    }
}

struct DummySearchContainer: View {
    @Namespace var namespace
    
    var body: some View {
        SearchDeductionsView(namespace: namespace, isSearching: .constant(true))
    }
}

struct Previews_DeductionsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        DummySearchContainer()
    }
}

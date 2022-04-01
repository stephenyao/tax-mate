//
//  ContentView.swift
//  tax-mate
//
//  Created by Stephen Yao on 16/2/22.
//

import SwiftUI
import CoreData

struct DeductionsView: View {
    @Namespace var namespace
    @State var isSearching = false
    @State var searchQuery = ""
    
    var body: some View {
        if isSearching {
            SearchDeductionsView(namespace: namespace, isSearching: $isSearching)
        } else {
            DeductionsListView(isSearching: $isSearching, namespace: namespace)            
        }        
    }
}

struct DeductionsView_Previews: PreviewProvider {
    static var previews: some View {
        DeductionsView()
    }
}

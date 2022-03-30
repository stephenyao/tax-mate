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

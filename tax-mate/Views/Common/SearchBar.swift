//
//  SearchBar.swift
//  tax-mate
//
//  Created by Stephen Yao on 30/3/22.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var query: String
    @Binding var isActive: Bool
    
    private var backgroundColor: Color {
        Color(UIColor.systemGray6)
    }
    
    private var foregroundColor: Color {
        Color(UIColor.systemGray)
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            GeometryReader { geo in
                TextField("Search", text: $query)
                    .frame(height: 44)
                    .onTapGesture {
                        withAnimation {
                            self.isActive = true
                        }
                    }
            }
            Spacer()
        }
        .padding([.leading], 4)
        .foregroundColor(foregroundColor)
        .padding(0)
        .frame(minWidth: 250)
        .frame(height: 44)
        .background(
            RoundedRectangle(cornerSize: CGSize(width: 11.0, height: 11.0))
                .foregroundColor(backgroundColor)
        )
    }
}

struct Previews_SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(query: .constant("test"), isActive: .constant(false)).preferredColorScheme(.light)
            .frame(width: 300)
        SearchBar(query: .constant("test"), isActive: .constant(false)).preferredColorScheme(.dark)
            .frame(width: 300)
    }
}

//
//  RecentDeductionsView.swift
//  tax-mate
//
//  Created by Stephen Yao on 11/5/2022.
//

import SwiftUI
import Fakery

struct RecentDeductions: View {
    @State private var contentHeight: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    private let headerHeight: CGFloat = 66
    
    private func computedOffset(proxy: GeometryProxy) -> CGFloat {
        let y = proxy.frame(in: .global).origin.y
        let diff = contentHeight - y
        if y < contentHeight {
            return  -contentHeight + headerHeight + diff
        } else {
            return -contentHeight + headerHeight
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(1...50, id:\.self) { i in
              Row()
            }
            .offset(y: headerHeight)
            
            GeometryReader { proxy in
                VStack {
                    HStack {
                        Text("Recent deductions")
                            .font(.headline)
                        Spacer()
                        NavigationLink("See all", destination: DeductionsView())
                    }
                }
                .padding([.leading, .trailing, .top])
                .frame(height: 96)
                .background(Color.white)
                .cornerRadius(15.0, corners: [.topLeft, .topRight])
                .offset(y: computedOffset(proxy: proxy))
            }
            .frame(height: 96)
            .shadow(color: .black.opacity(0.2), radius: 2.0, y: -4)
        }
        .frame(maxWidth: .infinity)
        .overlay(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: HeightPreference.self, value: proxy.size.height)
                
                Color.clear
                    .preference(key: OffsetPreference.self, value: proxy.frame(in: .global).origin.y)
            }
        )
        .onPreferenceChange(HeightPreference.self) { value in
            self.contentHeight = value
        }
        .onPreferenceChange(OffsetPreference.self) { value in
            self.offsetY = value
        }
    }
}

struct Row: View {
    @State private var alpha: Double = 1
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        Group {
            HStack {
                Text("Test")
                Spacer()
                Text("$500")
            }
            .padding([.leading, .trailing])
            Divider()
        }
        .overlay(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: OffsetPreference.self, value: proxy.frame(in: .global).origin.y)
            }
        )
        .onPreferenceChange(OffsetPreference.self) { value in
            self.offsetY = value
            if value < 112 {
                self.alpha = 0
            } else {
                self.alpha = 1
            }
        }
        .frame(height: 22)
        .background(Color.white)
        .opacity(alpha)
    }
}

//struct RecentDeductionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentDeductions(parentOffset: 0)
//        RecentDeductions(parentOffset: 0).preferredColorScheme(.dark)
//    }
//}

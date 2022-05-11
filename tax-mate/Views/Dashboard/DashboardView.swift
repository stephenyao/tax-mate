//
//  DashboardView.swift
//  tax-mate
//
//  Created by Stephen Yao on 21/4/2022.
//

import SwiftUI

struct HeightPreference: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct DashboardView: View {
    @State private var contentHeight: CGFloat = 0
    private let headerHeight: CGFloat = 200
    
    private func computedOffset(_ proxy: GeometryProxy) -> CGFloat {
        proxy.frame(in: .global).origin.y
    }
    
    private func computedHeight(_ proxy: GeometryProxy) -> CGFloat {
        let offsetY = proxy.frame(in: .global).origin.y
        let size: CGFloat = contentHeight
        let diff = headerHeight + offsetY - size
        
        if diff > 0 {
            return proxy.size.height + diff
        } else {
            return proxy.size.height
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                Group {
                    RecentDeductions()
                        .offset(y: headerHeight)
                    GeometryReader { reader in
                        let offsetY = computedOffset(reader)
                        Color.theme
                            .frame(height: computedHeight(reader))
                            .offset(y: -offsetY)
                        DashboardHeader()
                            .offset(y: -offsetY + computedHeight(reader) - 170)
                    }
                    .frame(height: headerHeight)
                }
                .overlay(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: HeightPreference.self, value: proxy.size.height)
                    }
                )
                .onPreferenceChange(HeightPreference.self) { value in
                    self.contentHeight = value
                }
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct RecentDeductions: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Recent deductions")
                    .font(.headline)
                Spacer()
                NavigationLink("See all", destination: DeductionsView())
            }
            .padding()
            
            ForEach(1...10, id:\.self) { i in
                Text(String(describing: i))
                    .frame(height: 100)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct DashboardHeader: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(1...6, id:\.self) { _ in
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.formBackground)
                        .frame(width: 120, height: 120)
                }
            }
            .padding()
            .frame(height: 170)
        }
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
        DashboardView().preferredColorScheme(.dark)
    }
}

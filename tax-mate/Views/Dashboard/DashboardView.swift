//
//  DashboardView.swift
//  tax-mate
//
//  Created by Stephen Yao on 21/4/2022.
//

import SwiftUI

struct DashboardView: View {
    @State private var contentHeight: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    private let headerHeight: CGFloat = 280
    
    private func computedOffset(_ proxy: GeometryProxy) -> CGFloat {
        proxy.frame(in: .global).origin.y
    }
    
    private func computedHeight(_ proxy: GeometryProxy) -> CGFloat {
        let offsetY = proxy.frame(in: .global).origin.y
        let size: CGFloat = contentHeight
        
        if offsetY > 0 {
            return proxy.size.height + offsetY
        } else {
            return proxy.size.height
        }
//        let diff = headerHeight + offsetY - size
//
//        if diff > 0 {
//            return proxy.size.height + diff
//        } else {
//            return proxy.size.height
//        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                Group {
                    GeometryReader { reader in
                        let offsetY = computedOffset(reader)
                        Color.themeBackground
                            .overlay(
                                ZStack {
                                    Color.clear
                                    DashboardHeader()
                                        .padding([.bottom])
                                }
                            )
                            .frame(height: computedHeight(reader))
                            .offset(y: -offsetY)
                    }
                    .frame(height: headerHeight)
                    
                    RecentDeductions()
                        .offset(y: -20)
                }
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
            .ignoresSafeArea(.all, edges: [.top])
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
        DashboardView().preferredColorScheme(.dark)
    }
}

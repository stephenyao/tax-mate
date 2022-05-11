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
        let size: CGFloat = 1188
        let diff = offsetY - size
        
        if diff > 0 {
            return proxy.size.height + diff
        } else {
            return proxy.size.height
        }
    }
    
    var body: some View {
        ScrollView {
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

                    Group {
                        Text("off: \(offsetY)")
                            .frame(width: 100, height: 50)
                            .offset(x: 30, y: 30)
                        Text("h: \(reader.frame(in: .global).size.height)")
                            .frame(width: 100, height: 50)
                            .offset(x: 30, y: 80)
                    }.offset(y: -offsetY)
                }
                .frame(height: headerHeight)
            }
            .background(
                GeometryReader { proxy in
                    Text("\(proxy.size.height)")
                        .offset(y: 300)
                        .preference(key: HeightPreference.self, value: proxy.size.height)
                }
                .background(Color.blue)
            )
            .onPreferenceChange(HeightPreference.self) { value in
                self.contentHeight = value
            }
        }
        .ignoresSafeArea()
    }
}

struct RecentDeductions: View {
    var body: some View {
        VStack(spacing: 20) {
            ForEach(1...10, id:\.self) { i in
                Text(String(describing: i))
                    .background(.red)
                    .frame(height: 100)
            }
        }
    }
}

struct DashboardHeader: View {
    var body: some View {
        ScrollView(.horizontal) {
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

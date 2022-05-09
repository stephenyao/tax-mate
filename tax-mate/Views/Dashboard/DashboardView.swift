//
//  DashboardView.swift
//  tax-mate
//
//  Created by Stephen Yao on 21/4/2022.
//

import SwiftUI

struct DashboardView: View {
    private func computedOffset(_ proxy: GeometryProxy) -> CGFloat {
        proxy.frame(in: .global).origin.y
    }
    
    private func computedHeight(_ proxy: GeometryProxy) -> CGFloat {
        let offsetY = proxy.frame(in: .global).origin.y
        if offsetY > 0 {
            return proxy.size.height + offsetY
        } else {
            return proxy.size.height
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                GeometryReader { reader in
                    let offsetY = computedOffset(reader)
                    
                    Color.theme
                        .frame(height: computedHeight(reader))
                        .offset(y: -offsetY)
                    
                    DashboardHeader()
                        .offset(y: -offsetY + computedHeight(reader) - 170)
                }
                .frame(height: 200)
                RecentDeductions()
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
        .frame(maxWidth: .infinity)
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

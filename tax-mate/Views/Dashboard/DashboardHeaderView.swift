//
//  DashboardHeaderView.swift
//  tax-mate
//
//  Created by Stephen Yao on 11/5/2022.
//

import SwiftUI

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

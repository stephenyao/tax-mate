//
//  RecentDeductionsView.swift
//  tax-mate
//
//  Created by Stephen Yao on 11/5/2022.
//

import SwiftUI

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

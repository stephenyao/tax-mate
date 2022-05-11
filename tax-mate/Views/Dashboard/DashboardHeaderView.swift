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
                        .frame(width: 170, height: 170)
                        .overlay(
                            VStack(spacing: 10) {
                                HStack {
                                    Text("FY 22")
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                Spacer()
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("$0.00")
                                            .font(.headline)
                                        Text("Total deductions")
                                            .font(.caption)
                                    }
                                    Spacer()
                                }
                            }
                            .padding()
                        )
                }
            }
            .padding()
            .frame(height: 170)
        }
    }
}

struct DashboardHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardHeader()
        DashboardHeader().preferredColorScheme(.dark)
    }
}

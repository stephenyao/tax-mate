//
//  RecentDeductionsView.swift
//  tax-mate
//
//  Created by Stephen Yao on 11/5/2022.
//

import SwiftUI
import Fakery

struct RecentDeductions: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Recent deductions")
                    .font(.headline)
                Spacer()
                NavigationLink("See all", destination: DeductionsView())
            }
            .padding([.top, .leading, .trailing])
            
            Divider()
            
            ForEach(1...20, id:\.self) { i in
                HStack {
                    Text(Faker().company.name())
                    Spacer()
                    Text(Formatter.sharedInstance.currency.string(from: NSNumber(value: Faker().number.randomDouble(min: 1, max: 500)))!)
                }
                .padding([.leading, .trailing])
                Divider()
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct RecentDeductionsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentDeductions()
        RecentDeductions().preferredColorScheme(.dark)
    }
}

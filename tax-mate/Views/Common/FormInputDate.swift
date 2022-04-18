//
//  FormInputDateRow.swift
//  tax-mate
//
//  Created by Stephen Yao on 15/4/2022.
//

import SwiftUI

struct FormInputDate: View {
    @Binding var date: Date
    let inputTitle: String
    @Binding var presentPicker: Bool
    var action: (() -> Void)?
    
    private var displayText: String {
        Formatter.sharedInstance.mediumDate.string(from: date)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(displayText)
                    .padding()
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.formBackground))
            .onTapGesture {
                withAnimation {
                    action?()
                    presentPicker.toggle()
                }
            }
            
            if presentPicker {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
        }
    }
}

private struct FormInputDateRowPreview: View {
    @State var date: Date = .now
    @State var presents = false
    
    var body: some View {
        FormInputDate(date: $date, inputTitle: "Date", presentPicker: $presents)
    }
}

struct FormInputDate_Previews: PreviewProvider {
    static var previews: some View {
        FormInputDateRowPreview()
    }
}

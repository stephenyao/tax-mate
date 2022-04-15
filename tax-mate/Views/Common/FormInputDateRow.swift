//
//  FormInputDateRow.swift
//  tax-mate
//
//  Created by Stephen Yao on 15/4/2022.
//

import SwiftUI
import Introspect

struct FormInputDateRow: View {
    @Binding var date: Date
    let inputTitle: String
    @State private var presentPicker = false        
    
    private var displayText: String {
        Formatter.sharedInstance.mediumDate.string(from: date)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(displayText)
                    .foregroundColor(Color(uiColor: .systemGray))
                    .padding()
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color(uiColor: .systemGray6))
            )
            .onTapGesture {
                withAnimation {
                    presentPicker.toggle()
                }
            }
            
            if presentPicker {
                DatePicker("Date", selection: $date)
                    .datePickerStyle(.graphical)
                    .onChange(of: self.date) { _ in
                        withAnimation {                            
                            presentPicker = false
                        }
                    }
                    .introspectDatePicker { picker in
                        picker.becomeFirstResponder()
                    }
            }
        }
    }
}

private struct FormInputDateRowPreview: View {
    @State var date: Date = .now
    
    var body: some View {
        FormInputDateRow(date: $date, inputTitle: "Date")
    }
}

struct FormInputDate_Previews: PreviewProvider {
    static var previews: some View {
        FormInputDateRowPreview()
    }
}

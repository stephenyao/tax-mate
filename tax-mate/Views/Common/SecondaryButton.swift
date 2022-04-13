//
//  SecondaryButton.swift
//  TaxDeducer
//
//  Created by Stephen Yao on 2/6/21.
//

import Foundation
import SwiftUI

struct SecondaryButton: View {
  
  let title: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(title)
        .fontWeight(.semibold)
        .foregroundColor(.theme)
        .padding()
        .frame(height: 37.0)
    }
    .buttonStyle(SecondaryButtonStyle())
  }
}

private struct SecondaryButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label      
      .cornerRadius(8.0)
    
  }
}

struct SecondaryButton_Previews: PreviewProvider {
  static var previews: some View {
    SecondaryButton(title: "Test") {
      print("tapped")
    }
  }
}

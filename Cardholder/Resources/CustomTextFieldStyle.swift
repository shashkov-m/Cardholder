//
//  CustomTextFieldStyle.swift
//  Cardholder
//
//  Created by Max Shashkov on 01.06.2022.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
  func _body(configuration: TextField<Self._Label>) -> some View {
    HStack {
      configuration
      Rectangle()
        .frame(width: 15, height: 15)
        .foregroundColor(.clear)
        .background(.clear)
    }
      .padding(6)
      .background(Color(uiColor: .quaternarySystemFill))
      .cornerRadius(6)
  }
}

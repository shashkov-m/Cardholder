//
//  CardTextFieldView.swift
//  Cardholder
//
//  Created by Max Shashkov on 23.07.2022.
//

import SwiftUI

struct CardTextFieldView: View {
    var textFieldName: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var systemImageName: String
    var secureField = false
    
    @ViewBuilder
    var view: some View {
        if secureField {
            SecureField(textFieldName, text: $text)
        } else {
            TextField(textFieldName, text: $text)
        }
    }
    
    var body: some View {
        view
            .keyboardType(keyboardType)
            .overlay(alignment: .trailing) {
                Image(systemName: systemImageName).offset(x: -5, y: 0)
            }
            .font(CustomFont.cardNumber.getFont)
            .disableAutocorrection(true)
            .textFieldStyle(CustomTextFieldStyle())
            .foregroundColor(.secondary)
    }
}

struct CardTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CardTextFieldView(textFieldName: "textFieldName",
                          text: .constant("Some string"),
                          systemImageName: "textformat.size")
    }
}

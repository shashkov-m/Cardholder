//
//  CardTextFieldToCopyView.swift
//  Cardholder
//
//  Created by Max Shashkov on 23.07.2022.
//

import SwiftUI

struct CardTextFieldToCopyView: View {
    var text: String
    
    init?(text: String) {
        guard text.count > 0 else { return nil }
        self.text = text
    }
    var body: some View {
        Text(text)
            .font(CustomFont.cardNumber.getFont)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 50)
            .background(Color(uiColor: .quaternarySystemFill))
            .cornerRadius(12)
    }
}

struct CardTextFieldToCopyView_Previews: PreviewProvider {
    static var previews: some View {
        CardTextFieldToCopyView(text: "some card text")
    }
}

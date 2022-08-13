//
//  CardTextFieldToCopyView.swift
//  Cardholder
//
//  Created by Max Shashkov on 23.07.2022.
//

import SwiftUI

struct CardTextFieldToCopyView: View {
    var text: String
    var systemImage: String
    private let copiedText = "Copied to Clipboard!"
    @State private var startAnimate = false {
        didSet {
            guard startAnimate else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    startAnimate = false
                }
            }
        }
    }
    
    var body: some View {
        if startAnimate {
            Text(copiedText)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Image(systemName: "checkmark.circle").offset(x: 10, y: 0)
                }
                .foregroundColor(.secondary)
                .transition(.opacity)
        } else {
            Text(text)
                .font(CustomFont.cardNumber.getFont)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Image(systemName: systemImage).offset(x: 10, y: 0)
                }
                .foregroundColor(.secondary)
                .transition(.opacity)
                .contentShape(Rectangle())
                .onTapGesture {
                    UIPasteboard.general.string = text
                    withAnimation {
                        startAnimate = true
                    }
                }
        }
    }
}

struct CardTextFieldToCopyView_Previews: PreviewProvider {
    static var previews: some View {
        CardTextFieldToCopyView(text: "some card text", systemImage: "textformat.123")
    }
}

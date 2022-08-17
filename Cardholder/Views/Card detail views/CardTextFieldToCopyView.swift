//
//  CardTextFieldToCopyView.swift
//  Cardholder
//
//  Created by Max Shashkov on 23.07.2022.
//

import SwiftUI

struct CardTextFieldToCopyView: View {
    @ObservedObject var viewModel: CardViewModel
    let text: String
    let fieldType: FieldType
    var isCardNumber: Bool {
        if case .number = fieldType { return true }
        else { return false }
    }
    private let copiedText = NSLocalizedString("copiedToClipboard", comment: "")
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
    
    enum FieldType {
        case number
        case cardholder
        case expireDate
        case cvv
        
        var icon: Image {
            switch self {
            case .number: return Image(systemName: "textformat.123")
            case .cardholder: return Image(systemName: "person.text.rectangle")
            case .expireDate: return Image(systemName: "calendar.badge.clock")
            case .cvv: return Image(systemName: "creditcard.and.123")
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
            Text(isCardNumber ? viewModel.makeCardDigits(text) : text)
                .font(CustomFont.cardNumber.getFont)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    fieldType.icon.offset(x: 10, y: 0)
                }
                .foregroundColor(.secondary)
                .transition(.opacity)
                .contentShape(Rectangle())
                .onTapGesture {
                    UIPasteboard.general.string = isCardNumber ? viewModel.makeNumber(text) : text
                    withAnimation {
                        startAnimate = true
                    }
                }
        }
    }
}

struct CardTextFieldToCopyView_Previews: PreviewProvider {
    static var previews: some View {
        CardTextFieldToCopyView(viewModel: CardViewModel(), text: "some card text", fieldType: .number)
    }
}

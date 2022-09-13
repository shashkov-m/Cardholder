//
//  CardTextFieldToCopyView.swift
//  Cardholder
//
//  Created by Max Shashkov on 23.07.2022.
//

import SwiftUI

struct CardTextFieldToCopyView: View {
    
    @ObservedObject var viewModel: CardViewModel
    @State private var isSecure = true
    var isPassword = false
    let text: String
    let fieldType: FieldType
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
    @ViewBuilder
    private var view: some View {
        switch fieldType {
        case .number: Text(viewModel.makeCardDigits(text))
        case .cvv: Text(isSecure ? String(repeating: "●", count: 3) : text)
        default: Text(text)
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
            view
                .font(CustomFont.cardNumber.getFont)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    fieldType.icon.offset(x: 10, y: 0)
                }
                .overlay(alignment: .trailing) {
                    if case .cvv = fieldType {
                        Image(systemName: isSecure ? "eye.fill" : "eye.slash.fill")
                            .offset(x: -10, y: 0)
                            .onTapGesture { isSecure.toggle() }
                    }
                    
                }
                .foregroundColor(.secondary)
                .transition(.opacity)
                .contentShape(Rectangle())
                .onTapGesture {
                    UIPasteboard.general.string = fieldType == .number ? viewModel.makeNumber(text) : text
                    withAnimation {
                        startAnimate = true
                    }
                    Analytics.shared.cardDataCopied(field: fieldType.rawValue)
                }
        }
    }
}

extension CardTextFieldToCopyView {
    enum FieldType: String {
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
}

struct CardTextFieldToCopyView_Previews: PreviewProvider {
    static var previews: some View {
        CardTextFieldToCopyView(viewModel: CardViewModel(), text: "some card text", fieldType: .number)
    }
}

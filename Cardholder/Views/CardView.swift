//
//  CardView.swift
//  Cardholder
//
//  Created by Max Shashkov on 26.05.2022.
//

import SwiftUI
import Combine

struct CardView: View {
  private let viewModel = CardViewModel()
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Bank Name")
        .font(.body)
      Text(viewModel.makeNumber(viewModel.card.number))
        .font(.custom("Thonburi", size: 16))
      Text(viewModel.card.cardholder ?? "")
      HStack(alignment: .center) {
        Group {
          VStack {
            Text("VALID THRU")
              .font(.caption)
            Text("05/28")
              .font(CustomFonts.digits.setFont)
          }
          Spacer()
          VStack {
            Text("CVV")
              .font(.caption)
            Text("✱✱✱")
              .font(CustomFonts.digits.setFont)
          }
        }
        Spacer()
        Image("mastercard")
      }
    }
    .frame(maxWidth: 300, maxHeight: 150)
    .clipped()
    .padding()
    .foregroundColor(.white)
    .background(LinearGradient(colors: [.orange, .purple], startPoint: .leading, endPoint: .trailing))
    .cornerRadius(12)
  }
  
  private enum CustomFonts {
    case cardNumber
    case digits
    
    var setFont: Font {
      let fontName = "Thonburi"
      switch self {
      case .cardNumber:
        return Font.custom(fontName, size: 16)
      case .digits:
        return Font.custom(fontName, size: 14)
      }
    }
    
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView()
  }
}

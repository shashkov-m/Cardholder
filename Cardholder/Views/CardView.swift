//
//  CardView.swift
//  Cardholder
//
//  Created by Max Shashkov on 26.05.2022.
//

import SwiftUI

struct CardView: View {
  var card: Card
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(card.name ?? "")
        .font(.body)
      Text(makeNumber(card.number))
        .font(CustomFonts.cardNumber.setFont)
      Text(card.cardholder ?? "")
      HStack(alignment: .center) {
        if let expireDate = card.expireDate {
          VStack {
            Text("VALID THRU")
              .font(.caption)
            Text(expireDate)
              .font(CustomFonts.digits.setFont)
          }
        }
        Spacer()
        card.provider.image()?
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: 64, maxHeight: 64)
      }
      .padding(.top, 12)
    }
    .frame(maxWidth: .infinity, maxHeight: 150)
    .clipped()
    .padding()
    .foregroundColor(card.style.textColor)
    .background(card.style.background)
    .cornerRadius(12)
    .shadow(radius: 6)
    
  }
  
  private func makeNumber(_ string: String) -> String {
    var result = ""
    string
      .publisher
      .collect(4)
      .scan("") { return $0 + $1 + " " }
      .sink { result = $0 }
    return result
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
    CardView(card: Card(name: "Bank Name", number: "4200400000000000", cardholder: "CARDHOLDER NAME",  expireDate: "12/26", style: .bluePinkGradient))
  }
}

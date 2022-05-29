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
      Text(card.number)
        .font(.custom("Thonburi", size: 16))
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
    }
    .frame(maxWidth: .infinity, maxHeight: 150)
    .clipped()
    .padding()
    .foregroundColor(.white)
    .background(card.style.view())
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
    CardView(card: Card(name: "Bank Name", number: "22004000000000000", cardholder: "CARDHOLDER NAME",  expireDate: "12/26", style: .bluePinkGradient))
  }
}

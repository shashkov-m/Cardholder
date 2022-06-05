//
//  CardView.swift
//  Cardholder
//
//  Created by Max Shashkov on 26.05.2022.
//

import SwiftUI

struct CardView: View {
  var card: Card
  var widht: CGFloat = 380
  var height: CGFloat = 180
  var body: some View {
    ZStack {
      EmptyCardView(width: widht, height: height, style: card.style, provider: card.provider)
      VStack(alignment: .leading, spacing: 10) {
        Text(card.name)
        Text(makeNumber(card.number))
          .font(CustomFont.cardNumber.setFont)
        Text(card.cardholder)
        HStack(alignment: .center) {
          if let expireDate = card.expireDate {
            VStack {
              Text("VALID THRU")
                .font(.caption)
              Text(expireDate)
                .font(CustomFont.digits.setFont)
            }
          }
          Spacer()
        }
      }
      .padding()
    }
    
    .foregroundColor(card.style.textColor)
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
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(card: Card(name: "Bank Name", number: "5200400000000000", cardholder: "CARDHOLDER NAME", expireDate: "12/26", cvv: "123", style: .bluePinkGradient, provider: .visa))
  }
}

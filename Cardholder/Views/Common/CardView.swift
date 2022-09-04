//
//  CardView.swift
//  Cardholder
//
//  Created by Max Shashkov on 26.05.2022.
//

import SwiftUI

struct CardView: View {
  @ObservedObject var viewModel: CardViewModel
  var card: Card
  var width: CGFloat = 380
  var height: CGFloat = 180
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 10) {
        Text(card.name)
          Text(viewModel.makeCardDigits(card.number))
          .font(CustomFont.cardNumber.getFont)
        Text(card.cardholder)
        if card.expireDate.count > 0 {
          VStack {
            Text("VALID THRU")
              .font(.caption)
            Text(card.expireDate)
              .font(CustomFont.digits.getFont)
          }
        }
      }
      Spacer()
    }
    .foregroundColor(card.style.textColor)
    .padding()
    .frame(width: width, height: height)
    .background(card.style.background)
    .cornerRadius(12)
    .overlay(alignment: .bottomTrailing) {
      card.provider.image()?
        .resizable()
        .scaledToFit()
        .frame(maxWidth: 64, maxHeight: 64)
        .offset(x: -15, y: 0)
    }
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
      CardView(viewModel: CardViewModel(), card: Card(orderIndex: 0, name: "Bank Name", number: "5200400000000000", cardholder: "CARDHOLDER NAME", expireDate: "12/26", cvv: "123", style: .bluePinkGradient, provider: .visa))
  }
}

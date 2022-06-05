//
//  CardStyleCollectionView.swift
//  Cardholder
//
//  Created by Max Shashkov on 03.06.2022.
//

import SwiftUI

struct CardStyleCollectionView: View {
  @Binding var card: Card
  
  var width: CGFloat = UIScreen.main.bounds.width * 0.75
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(CardStyle.allCases, id: \.hashValue) { value in
          VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
              if value.hashValue == card.style.hashValue {
                Image(systemName: "checkmark.circle.fill")
                  .foregroundColor(.white)
                  .offset(x: -15, y: 10)
                  .transition(.opacity)
                  .zIndex(1)
              }
              ZStack(alignment: .bottomLeading) {
                EmptyCardView(width: width, height: width / 2, style: value, provider: card.provider)
                  .frame(width: width, height: width / 2)
                  .zIndex(0)
                  .onTapGesture {
                    DispatchQueue.main.async {
                      withAnimation {
                        card.style = value
                      }
                    }
                  }
                
                if value.rawValue.count > 2 {
                  Text("by: \(value.rawValue)")
                    .foregroundColor(.secondary)
                    .font(.caption2)
                    .lineLimit(2)
                    .offset(x: 5, y: 17)
                }
              }
            }
          }
        }
      }
      .padding()
    }
  }
}

struct CardStyleCollectionView_Previews: PreviewProvider {
  static var previews: some View {
    CardStyleCollectionView(card: .constant(Card(name: "", number: "", cardholder: "", expireDate: "", cvv: "", style: .blackBG, provider: .mastercard)))
  }
}

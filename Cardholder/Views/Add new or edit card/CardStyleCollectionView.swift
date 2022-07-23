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
          Rectangle()
            .foregroundColor(.clear)
            .background(value.background)
            .frame(width: width, height: width / 2)
            .cornerRadius(12)
            .overlay(alignment: .bottomTrailing) {
              card.provider.image()?
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 64, maxHeight: 64)
                .offset(x: -15, y: 0)
            }
          
            .overlay(alignment: .topTrailing) {
              if value.hashValue == card.style.hashValue {
                Image(systemName: "checkmark.circle.fill")
                  .foregroundColor(.white)
                  .shadow(radius: 3)
                  .offset(x: -15, y: 10)
                  .transition(.opacity)
                  .zIndex(1)
              }
            }
          
            .overlay(alignment: .bottomLeading) {
              if value.rawValue.count > 2 {
                Text("by: \(value.rawValue)")
                  .foregroundColor(.secondary)
                  .font(.caption2)
                  .lineLimit(2)
                  .offset(x: 5, y: 17)
              }
            }
            .onTapGesture {
              DispatchQueue.main.async {
                withAnimation {
                  card.style = value
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
    CardStyleCollectionView(card: .constant(Card.empty()))
  }
}

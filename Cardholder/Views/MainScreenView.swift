//
//  MainScreenView.swift
//  Cardholder
//
//  Created by Max Shashkov on 25.05.2022.
//

import SwiftUI

struct MainScreenView: View {
  let viewModel: CardViewModel
  @State private var cards: [Card]
  @State private var offset = CGSize.zero
  init() {
    self.viewModel = CardViewModel()
    self.cards = .init(repeating: viewModel.card, count: 3)
  }
  var body: some View {
    NavigationView {
      ZStack(alignment: .bottom) {
        ScrollView {
          VStack {
            ForEach(cards) { card in
              CardView(card: card)
                .shadow(radius: 6)
                .frame(maxWidth: .infinity)
                .padding(.bottom, -25)
            }
          }
          .padding()
        }
        Button {
          
        } label: {
          AddNewCardButtonView()
            .padding()
        }
      }
      .navigationTitle("Cardholder")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("Notes") {
            
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Info") {
            
          }
        }
      }
      .foregroundColor(.gray)
    }
  }
}

struct MainScreenView_Previews: PreviewProvider {
  static var previews: some View {
    MainScreenView()
      //.preferredColorScheme(.dark)
  }
}

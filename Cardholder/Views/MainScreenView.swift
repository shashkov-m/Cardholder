//
//  MainScreenView.swift
//  Cardholder
//
//  Created by Max Shashkov on 25.05.2022.
//

import SwiftUI
import PartialSheet

struct MainScreenView: View {
  let viewModel: CardViewModel
  @State private var cards: [Card]
  @State private var isPartialSheet = false
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
                .frame(maxWidth: .infinity)
                .padding(.bottom, -25)
            }
          }
          .padding()
        }
        PSButton(isPresenting: $isPartialSheet) {
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
    .partialSheet(isPresented: $isPartialSheet) {
      Text("text in partial sheet")
    }
  }
}

struct MainScreenView_Previews: PreviewProvider {
  static var previews: some View {
    MainScreenView()
      .attachPartialSheetToRoot()
      //.preferredColorScheme(.dark)
  }
}

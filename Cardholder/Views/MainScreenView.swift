//
//  MainScreenView.swift
//  Cardholder
//
//  Created by Max Shashkov on 25.05.2022.
//

import SwiftUI
import PartialSheet

struct MainScreenView: View {
  @StateObject var viewModel = CardViewModel()
  private let PSiPhoneStyle = PSIphoneStyle(background: .blur(.ultraThinMaterial), handleBarStyle: .solid(.secondary), cover: .enabled(Color.black.opacity(0.3)), cornerRadius: 12)
  @State private var isCreateNewSheetPresented = false
  @State private var isPartialSheetPresented = false
  @State private var selectedCard: Card?
  private let width = UIScreen.main.bounds.width * 0.95
  
  var body: some View {
    NavigationView {
      ZStack(alignment: .bottom) {
        ScrollView(showsIndicators: false) {
          VStack {
            ForEach(viewModel.cards) { card in
              CardView(card: card, width: width)
                .padding(.bottom, -25)
                .transition(.scale)
                .onTapGesture {
                  selectedCard = card
                  isPartialSheetPresented.toggle()
                }
            }
            
            Rectangle()
              .frame(width: width, height: 100)
              .foregroundColor(.clear)
          }
        }
        
        Button {
          isCreateNewSheetPresented.toggle()
        } label: {
            RoundedButtonView(width: width * 0.9, text: "Add new card")
            
        }
        .padding()
      }
      .sheet(isPresented: $isCreateNewSheetPresented) {
        NavigationView {
          AddNewCardView(viewModel: viewModel, isPresented: $isCreateNewSheetPresented, title: "New Card")
        }
      }

      .partialSheet(isPresented: $isPartialSheetPresented, iPhoneStyle: PSiPhoneStyle) {
        if let card = selectedCard {
            CardDetails(viewModel: viewModel, isPresented: $isPartialSheetPresented, card: card, width: width)
        }
      }
      .navigationTitle("Cardholder")
      .navigationBarTitleDisplayMode(.large)
    }
    .navigationViewStyle(.stack)
  }
}

struct MainScreenView_Previews: PreviewProvider {
  static var previews: some View {
    MainScreenView(viewModel: CardViewModel())
      .attachPartialSheetToRoot()
      .preferredColorScheme(.dark)
  }
}

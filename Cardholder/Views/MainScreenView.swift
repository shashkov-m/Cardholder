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
  @State private var isSheetPresented = false
  private let width = UIScreen.main.bounds.width * 0.98
  
  var body: some View {
    NavigationView {
      ZStack(alignment: .bottom) {
        ScrollView(showsIndicators: false) {
          VStack {
            ForEach(viewModel.cards) { card in
              CardView(card: card, widht: width)
                .padding(.bottom, -25)
                .transition(.slide)
            }
            
            Rectangle()
              .frame(width: width, height: 100)
              .foregroundColor(.clear)
          }
        }
        
        Button {
          isSheetPresented.toggle()
        } label: {
          RoundedButtonView(width: 300, text: "Add new card")
            
        }
        .padding()
      }
      .sheet(isPresented: $isSheetPresented) {
        NavigationView {
          AddNewCardView(viewModel: viewModel, isPresented: $isSheetPresented)
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("Notes") {

          }
          .foregroundColor(.gray)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Info") {
          }
          .foregroundColor(.gray)
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
//      .preferredColorScheme(.dark)
  }
}

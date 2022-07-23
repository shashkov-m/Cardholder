//
//  CardDetails.swift
//  Cardholder
//
//  Created by Max Shashkov on 05.06.2022.
//

import SwiftUI

struct CardDetails: View {
  @State private var isEdit = false
  @ObservedObject var viewModel: CardViewModel
  var card: Card
  var width: CGFloat
  @Binding var isPresented: Bool
    var body: some View {
      VStack {
        HStack {
          Button("Delete") {
            
          }
          .foregroundColor(.red)
          Spacer()
          Button("Edit") {
            isEdit.toggle()
          }
        }
        .padding([.leading, .trailing], 15)
        .offset(x: 0, y: -25)
          ZStack(alignment: .bottomTrailing) {
              HStack {
                  Text(card.name)
                  Spacer()
              }
              .foregroundColor(card.style.textColor)
              .padding()
              .frame(width: width, height: 65)
              .background(card.style.background.aspectRatio(contentMode: .fill))
              .cornerRadius(12)
              card.provider.image()
                  .zIndex(0)
                  .offset(x: -10, y: 0)
          }
        Text("Tap on the field to copy")
          .foregroundColor(.secondary)
          .font(CustomFont.digits.getFont)
        
        VStack {
            CardTextFieldToCopyView(text: card.number)
          Divider()
          Text(card.cardholder)
          Divider()
          Text(card.expireDate)
          Divider()
          Text(card.cvv)
          }
        .padding()
      }
      .sheet(isPresented: $isEdit) {
        NavigationView {
          AddNewCardView(card, viewModel: viewModel, isPresented: $isEdit, title: card.name)
        }
      }
    }
}

struct CardDetails_Previews: PreviewProvider {
  
    static var previews: some View {
      let card = Card(name: "Card", number: "5234345345433456", cardholder: "HOLDER", expireDate: "14/88", cvv: "123", style: .blackLeafs, provider: .mastercard)
      CardDetails(viewModel: CardViewModel(), card: card, width: 380, isPresented: .constant(true))
    }
}

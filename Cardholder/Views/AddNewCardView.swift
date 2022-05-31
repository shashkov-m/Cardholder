//
//  AddNewCardView.swift
//  Cardholder
//
//  Created by Max Shashkov on 29.05.2022.
//

import SwiftUI
import Combine

struct InlineTextFieldStyle: TextFieldStyle {
  func _body(configuration: TextField<Self._Label>) -> some View {
    VStack() {
      configuration
      Divider()
        .background(.white)
    }
  }
}

struct AddNewCardView: View {
  var card: Card?
  @Binding var isPresented: Bool
  private let width = UIScreen.main.bounds.width / 1.3
  @State private var style: Card.CardStyle = .allCases[0]
  @State private var provider: Card.Provider = .none
  @State private var name: String = ""
  @State private var number: String = ""
  @State private var cardholder: String = ""
  @State private var expireDate: String = ""
  @State private var cvv: String = ""
  
  init(_ card: Card?, binding isPresented: Binding<Bool>) {
    self._isPresented = isPresented
    self.card = card
    self.style = card?.style ?? .bluePinkGradient
    self.provider = card?.provider ?? .none
    self.name = card?.name ?? ""
    self.number = card?.number ?? ""
    self.cardholder = card?.cardholder ?? ""
    self.expireDate = card?.expireDate ?? ""
    self.cvv = card?.cvv ?? ""
  }
  
  var body: some View {
    VStack {
      HStack {
      Text("New Card")
        Spacer()
      }
      .padding([.leading, .trailing])
      .foregroundColor(.secondary)
      .font(.headline)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(Card.CardStyle.allCases, id: \.hashValue) { value in
            VStack(alignment: .leading) {
              ZStack(alignment: .topTrailing) {
                if value.hashValue == style.hashValue {
                  Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.white)
                    .offset(x: -15, y: 10)
                    .transition(.opacity)
                    .zIndex(1)
                }
                ZStack(alignment: .bottomLeading) {
                  EmptyCardView(width: width, height: width / 2, style: value, provider: .mastercard)
                    .zIndex(0)
                    .onTapGesture {
                      withAnimation {
                        style = value
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
      
      VStack {
        TextField("Card name", text: $name)
          .keyboardType(.asciiCapable)
        TextField("Number", text: $number)
          .keyboardType(.numberPad)
          .font(Card.Font.cardNumber.setFont)
        TextField("Cardholder name", text: $cardholder)
          .keyboardType(.namePhonePad)
        HStack {
          TextField("Expire date", text: $expireDate)
          TextField("CVV", text: $cvv)
        }
        .keyboardType(.numberPad)
        .font(Card.Font.digits.setFont)
      }
      .background(.clear)
      .lineLimit(1)
      .disableAutocorrection(true)
      .textFieldStyle(InlineTextFieldStyle())
      .font(.headline)
      .foregroundColor(.secondary)
      .padding()
      
      Button {
        isPresented.toggle()
      } label: {
        AddNewCardButtonView()
      }
      
    }
  }
}

struct AddNewCardView_Previews: PreviewProvider {
  static var previews: some View {
    AddNewCardView(nil, binding: .constant(true))
//      .preferredColorScheme(.dark)
  }
}

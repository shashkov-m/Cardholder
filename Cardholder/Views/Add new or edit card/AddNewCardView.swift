//
//  AddNewCardView.swift
//  Cardholder
//
//  Created by Max Shashkov on 29.05.2022.
//

import SwiftUI
import Combine

struct AddNewCardView: View {
  @State private var card: Card = .empty()
  @ObservedObject var viewModel: CardViewModel
  @Binding var isPresented: Bool
  @State private var isKeyboardPresented = false
  @FocusState private var field: Field?
  private let width = UIScreen.main.bounds.width * 0.75
  
  private enum Field: Int, CaseIterable {
    case name, cardholder, number, expire, cvv
  }
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        CardStyleCollectionView(card: $card)
        
        VStack {
          ZStack(alignment: .trailing) {
            TextField("Card name", text: $card.name)
              .focused($field, equals: .name)
              .keyboardType(.namePhonePad)
            Image(systemName: "textformat.size")
              .offset(x: -5, y: 0)
          }
          
          ZStack(alignment: .trailing) {
            TextField("Cardholder name", text: $card.cardholder)
              .focused($field, equals: .cardholder)
              .keyboardType(.asciiCapable)
            Image(systemName: "person.text.rectangle")
              .offset(x: -5, y: 0)
          }
          
          ZStack(alignment: .trailing) {
            TextField("Number", text: $card.number)
              .focused($field, equals: .number)
              .onChange(of: card.number) { newValue in
                DispatchQueue.main.async {
                  card.number = viewModel.makeCardDigits(newValue)
                  card.provider = viewModel.getProvider(newValue)
                }
              }
              .keyboardType(.numberPad)
            Image(systemName: "textformat.123")
              .offset(x: -5, y: 0)
          }
          
          HStack {
            ZStack(alignment: .trailing) {
              TextField("Expire (06/28)", text: $card.expireDate)
                .focused($field, equals: .expire)
                .onChange(of: card.expireDate) { newValue in
                  DispatchQueue.main.async {
                    card.expireDate = viewModel.makeExpireDate(newValue)
                  }
                }
              Image(systemName: "calendar.badge.clock")
                .offset(x: -5, y: 0)
            }
            
            ZStack(alignment: .trailing) {
              SecureField("CVV", text: $card.cvv)
                .focused($field, equals: .cvv)
                .onChange(of: card.cvv) { newValue in
                  DispatchQueue.main.async {
                    card.cvv = String(newValue.prefix(3))
                  }
                }
              Image(systemName: "creditcard.and.123")
                .offset(x: -5, y: 0)
            }
          }
          .keyboardType(.numberPad)
        }
        .font(CustomFont.cardNumber.setFont)
        .disableAutocorrection(true)
        .textFieldStyle(CustomTextFieldStyle())
        .foregroundColor(.secondary)
        .padding()
        .onReceive(keyboardPublisher) { value in
          withAnimation {
            isKeyboardPresented = value
          }
        }
        
        if !isKeyboardPresented {
          VStack {
            Button {
              withAnimation {
                viewModel.cards.append(card)
                isPresented.toggle()
              }
            } label: {
              RoundedButtonView(width: width, text: "Encrypt and Save")
            }
            
            Text("Credit card data will be encrypted and saved in local storage.")
              .multilineTextAlignment(.center)
              .font(.caption2)
              .foregroundColor(.secondary)
              .frame(width: 240)
            
          }
        }
      }
      .toolbar {
        ToolbarItemGroup(placement: .keyboard) {
          HStack {
            
            Button {
              guard let index = field?.rawValue, index > 0 else { return }
              field = Field.allCases[index - 1]
            } label: {
              Image(systemName: "lessthan")
            }
            
            Button {
              guard let index = field?.rawValue, index < Field.allCases.count - 1 else { return }
              field = Field.allCases[index + 1]
            } label: {
              Image(systemName: "greaterthan")
            }
            Spacer()
            Button("Done") {
              field = nil
            }
          }
        }
      }
      .onTapGesture {
        self.hideKeyboard()
      }
    }
    .navigationTitle("New Card")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct AddNewCardView_Previews: PreviewProvider {
  static var previews: some View {
    AddNewCardView(viewModel: CardViewModel(), isPresented: .constant(true))
    //      .preferredColorScheme(.dark)
  }
}

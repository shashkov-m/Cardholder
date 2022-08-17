//
//  AddNewCardView.swift
//  Cardholder
//
//  Created by Max Shashkov on 29.05.2022.
//

import SwiftUI

struct AddNewCardView: View {
  @State private var card: Card
  @ObservedObject var viewModel: CardViewModel
  @Binding var isPresented: Bool
  @State private var isKeyboardPresented = false
  @FocusState private var field: Field?
  private let title: String
  private let width = UIScreen.main.bounds.width * 0.75
  
  private enum Field: Int, CaseIterable {
    case name, number, cardholder, expire, cvv
  }
  
  init(_ card: Card = Card.empty(),
       viewModel: CardViewModel,
       isPresented: Binding<Bool>,
       title: String) {
    _card = State(initialValue: card)
    self.viewModel = viewModel
    self._isPresented = isPresented
    self.title = title
  }
    
    private func formatCardNumber() {
        card.number = viewModel.makeCardDigits(card.number)
    }
    
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        CardStyleCollectionView(card: $card)
          
          VStack {
              CardTextFieldView(textFieldName: NSLocalizedString("cardName", comment: ""),
                                text: $card.name,
                                keyboardType: .namePhonePad,
                                systemImageName: "textformat.size")
              .focused($field, equals: .name)
              
              CardTextFieldView(textFieldName: NSLocalizedString("number", comment: ""),
                                text: $card.number,
                                keyboardType: .numberPad,
                                systemImageName: "textformat.123")
              .focused($field, equals: .number)
              .onChange(of: card.number) { newValue in
                  DispatchQueue.main.async {
                      card.number = viewModel.makeCardDigits(newValue)
                      card.provider = viewModel.getProvider(newValue)
                  }
              }
              
              CardTextFieldView(textFieldName: NSLocalizedString("cardholder", comment: ""),
                                text: $card.cardholder,
                                keyboardType: .asciiCapable,
                                systemImageName: "person.text.rectangle")
              .focused($field, equals: .cardholder)
              
              HStack {
                  CardTextFieldView(textFieldName: NSLocalizedString("expire", comment: ""),
                                    text: $card.expireDate,
                                    keyboardType: .numberPad,
                                    systemImageName: "calendar.badge.clock")
                  .focused($field, equals: .expire)
                  .onChange(of: card.expireDate) { newValue in
                      DispatchQueue.main.async {
                          card.expireDate = viewModel.makeExpireDate(newValue)
                      }
                  }
                  CardTextFieldView(textFieldName: NSLocalizedString("cvv", comment: ""),
                                    text: $card.cvv,
                                    keyboardType: .numberPad,
                                    systemImageName: "creditcard.and.123",
                                    secureField: true)
                  .focused($field, equals: .cvv)
                  .onChange(of: card.cvv) { newValue in
                      DispatchQueue.main.async {
                          card.cvv = String(newValue.prefix(3))
                      }
                  }
              }
          }
        .padding()
        .onReceive(keyboardPublisher) { value in
          withAnimation {
            isKeyboardPresented = value
          }
        }
        
        if !isKeyboardPresented {
          VStack {
            Button {
                var card = card
                card.number = viewModel.makeNumber(card.number)
                viewModel.save(card)
                isPresented.toggle()
            } label: {
              RoundedButtonView(width: width, text: NSLocalizedString("saveButton", comment: ""))
            }
            
            Text("saveDescription")
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
            Button("done") {
              field = nil
            }
          }
        }
      }
      .onTapGesture {
        self.hideKeyboard()
      }
    }
    .onAppear {
        formatCardNumber()
    }
    .navigationTitle(title)
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct AddNewCardView_Previews: PreviewProvider {
  static var previews: some View {
    AddNewCardView(viewModel: CardViewModel(), isPresented: .constant(true), title: "New Card")
  }
}

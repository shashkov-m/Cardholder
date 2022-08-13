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
    @Binding var isPresented: Bool
    var card: Card
    var width: CGFloat
    private let background: Color = .white
    
    var body: some View {
        VStack {
            HStack {
                Button("Delete") {
                    viewModel.delete(card: card)
                    isPresented = false
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
                .background(card.style.background.aspectRatio(contentMode: .fill).allowsHitTesting(false))
                .cornerRadius(12)
                card.provider.image()?
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 64, maxHeight: 64)
                    .zIndex(0)
                    .offset(x: -10, y: 0)
            }
            Text("Tap on the field to copy")
                .foregroundColor(.secondary)
                .font(CustomFont.digits.getFont)
                .offset(x: 0, y: 5)
            
            VStack {
                if !card.number.isEmpty {
                    CardTextFieldToCopyView(text: card.number, systemImage: "textformat.123")
                    Divider()
                }
                if !card.cardholder.isEmpty {
                    CardTextFieldToCopyView(text: card.cardholder, systemImage: "person.text.rectangle")
                    Divider()
                }
                if !card.expireDate.isEmpty {
                    CardTextFieldToCopyView(text: card.expireDate, systemImage: "calendar.badge.clock")
                }
                if !card.expireDate.isEmpty && !card.cvv.isEmpty {
                    Divider()
                }
                if !card.cvv.isEmpty {
                    CardTextFieldToCopyView(text: card.cvv, systemImage: "creditcard.and.123")
                }
            }
            .padding([.top, .bottom], 12)
            .font(CustomFont.cardNumber.getFont)
            .foregroundColor(.secondary)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .padding()
            .offset(x: 0, y: -12)
        }
        .sheet(isPresented: $isEdit, onDismiss: didDismissEditView) {
            NavigationView {
                AddNewCardView(card, viewModel: viewModel, isPresented: $isEdit, title: card.name)
            }
        }
    }
    private func didDismissEditView() {
        isPresented.toggle()
    }
}

struct CardDetails_Previews: PreviewProvider {
    
    static var previews: some View {
        let card = Card(name: "Card", number: "5234345345433456", cardholder: "HOLDER", expireDate: "14/88", cvv: "123", style: .blackLeafs, provider: .mastercard)
        CardDetails(viewModel: CardViewModel(), isPresented: .constant(true), card: card, width: 380)
    }
}

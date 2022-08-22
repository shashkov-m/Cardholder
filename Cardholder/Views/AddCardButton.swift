//
//  AddCardButton.swift
//  Cardholder
//
//  Created by Max Shashkov on 17.08.2022.
//

import SwiftUI

struct AddCardButton: View {
    @Binding var binding: Bool
    let width: CGFloat
    
    var body: some View {
        Rectangle()
            .ignoresSafeArea()
            .frame(height: 70)
            .background(.bar)
            .blur(radius: 1)
            .opacity(0.4)
            .overlay(alignment: .top) {
                Button {
                    binding.toggle()
                } label: {
                    RoundedButtonView(width: width * 0.9, text: NSLocalizedString("addNewCard", comment: "Add new card"))
                }
                .offset(x: 0, y: 3)
            }
    }
}

struct AddCardButton_Previews: PreviewProvider {
    static var previews: some View {
        AddCardButton(binding: .constant(false), width: 390)
    }
}

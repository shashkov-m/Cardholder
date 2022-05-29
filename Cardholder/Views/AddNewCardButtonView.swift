//
//  AddNewCardButtonView.swift
//  Cardholder
//
//  Created by Max Shashkov on 25.05.2022.
//

import SwiftUI

struct AddNewCardButtonView: View {
  var body: some View {
    Text("Add new card")
      .font(.headline)
      .foregroundColor(.white)
      .padding()
      .frame(maxWidth: 300)
      .background(LinearGradient(colors: [.blue, .pink], startPoint: .topLeading, endPoint: .trailing))
      .cornerRadius(12)
      .shadow(radius: 12)
    
  }
}

struct AddNewCardButtonView_Previews: PreviewProvider {
  static var previews: some View {
    AddNewCardButtonView()
  }
}

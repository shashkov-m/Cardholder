//
//  MainScreenView.swift
//  Cardholder
//
//  Created by Max Shashkov on 25.05.2022.
//

import SwiftUI

struct MainScreenView: View {
  var body: some View {
    ZStack(alignment: .bottom) {
      Text("Hello, world!")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
      Button {
        
      } label: {
        AddNewCardButtonView()
      }

    }
  }
}

struct MainScreenView_Previews: PreviewProvider {
  static var previews: some View {
    MainScreenView()
  }
}

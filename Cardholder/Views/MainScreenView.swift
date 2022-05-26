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
      List {
        ForEach(0..<5) { _ in
          CardView()
        }
      }
      .listStyle(.sidebar)
      Button {
        
      } label: {
        AddNewCardButtonView()
          .padding()
      }
      
    }
  }
}

struct MainScreenView_Previews: PreviewProvider {
  static var previews: some View {
    MainScreenView()
  }
}

//
//  RoundedButtonView.swift
//  Cardholder
//
//  Created by Max Shashkov on 25.05.2022.
//

import SwiftUI

struct RoundedButtonView: View {
  var width: CGFloat
  var text: String = "button"
  
  var body: some View {
    Text(text)
      .font(.headline)
      .foregroundColor(.white)
      .padding()
      .frame(width: width)
      .background(.blue.opacity(0.9))
      .cornerRadius(12)
  }
}

struct RoundedButtonView_Previews: PreviewProvider {
  static var previews: some View {
    RoundedButtonView(width: 300)
  }
}

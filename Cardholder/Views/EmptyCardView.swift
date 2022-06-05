//
//  EmptyCardView.swift
//  Cardholder
//
//  Created by Max Shashkov on 30.05.2022.
//

import SwiftUI

struct EmptyCardView: View {
  var width: CGFloat
  var height: CGFloat
  var style: CardStyle
  var provider: Provider
  
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      Rectangle()
        .foregroundColor(.clear)
        .background(style.background)
      
      provider.image()?
        .resizable()
        .scaledToFit()
        .frame(maxWidth: 64, maxHeight: 64)
        .offset(x: -15, y: 0)
    }
    .frame(width: width, height: height)
    .cornerRadius(12)
  }
}

struct EmptyCardView_Previews: PreviewProvider {
    static var previews: some View {
      EmptyCardView(width: 380, height: 200, style: .orangeRedGradient ,provider: .mir)
    }
}

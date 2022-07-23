//
//  CardStyle.swift
//  Cardholder
//
//  Created by Max Shashkov on 01.06.2022.
//

import SwiftUI

enum CardStyle: String, CaseIterable, Codable {
  case blackBG = "Adrien Olichon"
  case yellowBananas = "Aleksandar Pasaric"
  case whitePillars = "cottonbro"
  case blackLeafs = "Elijah O'Donnell"
  case bluePinkGradient = "0"
  case orangeRedGradient = "1"
  
  var textColor: Color {
    switch self {
    case .yellowBananas:
      return .init(UIColor(hue: 0.1655, saturation: 1, brightness: 1, alpha: 1.0))
    default:
      return .white
    }
  }
  
  @ViewBuilder
  var background: some View {
    switch self {
    case .bluePinkGradient:
      LinearGradient(colors: [.blue, .pink], startPoint: .leading, endPoint: .trailing)
    case .orangeRedGradient:
      LinearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .trailing)
    case .whitePillars, .yellowBananas:
      Image(self.rawValue)
        .resizable()
        .overlay(.black.opacity(0.2))
    default:
      Image(self.rawValue)
        .resizable()
    }
  }
}

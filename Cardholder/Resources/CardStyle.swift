//
//  CardStyle.swift
//  Cardholder
//
//  Created by Max Shashkov on 01.06.2022.
//

import SwiftUI

enum CardStyle: String, CaseIterable, Codable {
  case blackBG = "Adrien Olichon"
  case blackLeafs = "Elijah O'Donnell"
  case space = "Pexels"
  case whitePillars = "cottonbro"
  case colorfulBlur = "David"
  case pinkSmoke = "rawpixel"
  case blueLines = "vector_corp"
  case blackAndRed = "BiZkettE1"
  case purpleAndPink = "saragnzalez"
  case goldenLeafs = "rawpixel.com"
  case bluePinkGradient = "shashkov.bluePinkGradient"
  case orangeRedGradient = "shashkov.orangeRedGradient"
  
  var textColor: Color {
    switch self {
    case .pinkSmoke:
        return .init(UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0))
//    case .yellowBananas:
//      return .init(UIColor(hue: 0.1655, saturation: 1, brightness: 1, alpha: 1.0))
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
    case .whitePillars,
            .colorfulBlur,
            .purpleAndPink,
            .goldenLeafs:
      Image(self.rawValue)
        .resizable()
        .overlay(.black.opacity(0.2))
    case .pinkSmoke:
        Image(self.rawValue)
            .resizable()
            .overlay(.white.opacity(0.25))
    default:
      Image(self.rawValue)
        .resizable()
    }
  }
}

//
//  CustomFont.swift
//  Cardholder
//
//  Created by Max Shashkov on 01.06.2022.
//

import SwiftUI

enum CustomFont {
  case cardNumber
  case digits
  
  var getFont: Font {
    let fontName = "Thonburi"
    switch self {
    case .cardNumber:
      return Font.custom(fontName, size: 16)
    case .digits:
      return Font.custom(fontName, size: 14)
    }
  }
}

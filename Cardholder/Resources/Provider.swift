//
//  Provider.swift
//  Cardholder
//
//  Created by Max Shashkov on 01.06.2022.
//

import SwiftUI

enum Provider: String {
  case visa
  case mastercard
  case maestro
  case mir
  case unionpay
  case jcb
  case none
  
  func image() -> Image? {
    guard self != .none else { return nil }
    return Image(self.rawValue)
  }
}

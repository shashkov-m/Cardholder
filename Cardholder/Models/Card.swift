//
//  Card.swift
//  Cardholder
//
//  Created by Max Shashkov on 26.05.2022.
//

import SwiftUI

struct Card: Identifiable {
  let id = UUID()
  var name: String?
  var number: String
  var cardholder: String?
  var expireDate: String?
  var cvv: String?
  var style: CardStyle
  var provider: Provider {
    getProvider(number)
  }
  
  enum CardStyle {
    case bluePinkGradient
    case blackBG
    
    var textColor: Color {
      switch self {
      case .bluePinkGradient, .blackBG:
        return .white
      default:
        return .black
      }
    }
    
    @ViewBuilder
    var background: some View {
      switch self {
      case .bluePinkGradient:
        LinearGradient(colors: [.blue, .pink], startPoint: .leading, endPoint: .trailing)
      case .blackBG :
        Image("blackBG")
          .resizable()
      }
    }
  }
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
  
  private func getProvider(_ string: String) -> Provider {
    let array = number.compactMap { $0.wholeNumberValue }
    guard array.count >= 12 else { return .none }
    
    let visa = 4
    let mastercard = 51...55
    let unoinPay = 62
    let jcb = 3528...3589
    let mir = 2200...2204
    let maestro = [5018, 5020, 5038, 5893, 6304, 6759, 6761, 6762, 6763]
    
    if array.first == visa {
      return .visa
    }
    
    let twoDigits = Int("\(array[0])\(array[1])") ?? 0
    if mastercard.contains(twoDigits) {
      return .mastercard
    } else if unoinPay == twoDigits {
      return .unionpay
    }
    
    let fourDigits = Int("\(twoDigits)\(array[2])\(array[3])") ?? 0
    if mir.contains(fourDigits) {
      return .mir
    } else if jcb.contains(fourDigits) {
      return .jcb
    } else if maestro.contains(fourDigits) {
      return .maestro
    } else {
      return .none
    }
  }
}


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
  var number: String?
  var cardholder: String?
  var expireDate: String?
  var cvv: String?
  var style: CardStyle = .bluePinkGradient
  var provider: Provider = .none
  
  enum CardStyle: String, CaseIterable {
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
  
  enum Font {
    case cardNumber
    case digits
    
    var setFont: SwiftUI.Font {
      let fontName = "Thonburi"
      switch self {
      case .cardNumber:
        return SwiftUI.Font.custom(fontName, size: 16)
      case .digits:
        return SwiftUI.Font.custom(fontName, size: 14)
      }
    }
    
  }
  
  private func getProvider(_ string: String) -> Provider {
    guard let array = number?.compactMap({ $0.wholeNumberValue }), array.count >= 12 else { return .none }
    
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


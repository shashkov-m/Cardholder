//
//  CardViewModel.swift
//  Cardholder
//
//  Created by Max Shashkov on 26.05.2022.
//

import SwiftUI
import Combine

final class CardViewModel: ObservableObject {
  let storage = Storage()
  @Published var cards = [Card]()
  private var subscriptions = Set<AnyCancellable>()
  private let key256 = "12345678901234561234567890123456"   // 32 bytes for AES256
  private let iv = "abcdefghijklmnop"
  @Published var lastEncryptedCard: Data?
  
  init() {
    storage.getSavedData()
      .sink { [unowned self] value in
        self.cards = value
      }
      .store(in: &subscriptions)
  }
  
  func saveCard(_ card: Card) {
    DispatchQueue.global().async { [unowned self] in
      self.cards.forEach { element in
        if element.id == card.id {
          DispatchQueue.main.async {
           // element = card
          }
        }
      }
      DispatchQueue.main.async {
        withAnimation {
          self.cards.append(card)
        }
      }
    }
  }
  
  @inlinable func makeCardDigits (_ string: String) -> String {
    let formattedString = string.replacingOccurrences(of: " ", with: "")
    guard formattedString.count <= 19 else {
      return String(formattedString.prefix(19))
    }
    let numbers = formattedString.compactMap { $0.wholeNumberValue }
    let indexes = [4, 8, 12, 16]
    var result = ""
    for i in 0..<numbers.count {
      if indexes.contains(i) {
        result.append(" ")
      }
      result.append(String(numbers[i]))
    }
    return result
  }
  
  @inlinable func getProvider(_ string: String) -> Provider {
    let formattedString = string.replacingOccurrences(of: " ", with: "")
    let numbers = formattedString.compactMap { $0.wholeNumberValue }
    
    let visa = 4
    let mastercard = 51...55
    let unoinPay = 62
    let jcb = 3528...3589
    let mir = 2200...2204
    let maestro = [5018, 5020, 5038, 5893, 6304, 6759, 6761, 6762, 6763]
    
    if numbers.first == visa {
      return .visa
    }
    
    guard numbers.count >= 4 else { return .none }
    let twoDigits = Int(numbers[0...1].reduce("") {"\($0)\($1)"}) ?? 0
    if mastercard.contains(twoDigits) {
      return .mastercard
    } else if unoinPay == twoDigits {
      return .unionpay
    }
    
    let fourDigits = Int(numbers[0...3].reduce("") {"\($0)\($1)"}) ?? 0
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
  
  @inlinable func makeExpireDate(_ string: String) -> String {
    let formattedString = string.replacingOccurrences(of: "/", with: "")
    guard formattedString.count <= 4 else {
      return String(formattedString.prefix(4))
    }
    let numbers = formattedString.compactMap { $0.wholeNumberValue }
    let index = 2
    var result = ""
    for i in 0..<numbers.count {
      if index == i {
        result.append("/")
      }
      result.append(String(numbers[i]))
    }
    return result
  }
}

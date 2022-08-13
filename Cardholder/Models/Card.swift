//
//  Card.swift
//  Cardholder
//
//  Created by Max Shashkov on 26.05.2022.
//

import SwiftUI

struct Card: Identifiable, Hashable, Equatable, Codable {
  var id = UUID()
  var name: String
  var number: String
  var cardholder: String
  var expireDate: String
  var cvv: String
  var style: CardStyle
  var provider: Provider
    
  static func empty() -> Card {
    Card(name: "", number: "", cardholder: "", expireDate: "", cvv: "", style: .allCases.first ?? .bluePinkGradient, provider: .none)
  }
  
}


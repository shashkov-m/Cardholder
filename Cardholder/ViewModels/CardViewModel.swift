//
//  CardViewModel.swift
//  Cardholder
//
//  Created by Max Shashkov on 26.05.2022.
//

import Foundation

final class CardViewModel {
  let card = Card(name: "Bank Name", number: "4564573958673845", cardholder: "CARDHOLDER NAME", expireDate: "0528", cvv: "123", style: .blackBG)
  func makeNumber(_ string: String) -> String {
    var result = ""
    string
      .publisher
      .collect(4)
      .scan("") { return $0 + $1 + " " }
      .sink { result = $0 }
    return result
  }
}

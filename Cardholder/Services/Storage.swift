//
//  Storage.swift
//  Cardholder
//
//  Created by Max Shashkov on 01.06.2022.
//

import Foundation
import Combine

final class Storage {
  func getSavedData() -> Future<[Card], Never> {
    Future() { promice in
      let testCard = Card(name: "Card name", number: "4000 0000 0000 0000", cardholder: "CARDHOLDER NAME", expireDate: "12/24", cvv: "123", style: .blackBG, provider: .visa)
      promice(.success([testCard]))
    }
  }
}

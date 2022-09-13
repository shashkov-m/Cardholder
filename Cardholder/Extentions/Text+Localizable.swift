//
//  Text+Localizable.swift
//  Cardholder
//
//  Created by Max Shashkov on 11.09.2022.
//

import SwiftUI

extension Text {
    init(_ localizable: Localizable) {
        let text = NSLocalizedString(localizable.rawValue, comment: "")
        self.init(text)
    }
}

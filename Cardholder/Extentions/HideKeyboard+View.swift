//
//  HideKeyboard+View.swift
//  Cardholder
//
//  Created by Max Shashkov on 31.05.2022.
//
import UIKit
import SwiftUI
import Combine

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

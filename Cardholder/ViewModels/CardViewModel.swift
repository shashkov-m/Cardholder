//
//  CardViewModel.swift
//  Cardholder
//
//  Created by Max Shashkov on 26.05.2022.
//

import SwiftUI
import Combine

final class CardViewModel: ObservableObject {
    private let storage = Storage()
    private var subscriptions = Set<AnyCancellable>()
    @Published var cards = [Card]()
    var needReorder = false
    
    init() {
        loadAll()
        configureObservers()
    }
    
    
    func save(_ card: Card) {
        storage.save(card: card)
        Analytics.shared.cardSaved(imageName: card.style.rawValue)
    }
    
    func loadAll() {
        storage.loadAll()
            .sink { [weak self] cards in
                withAnimation {
                    self?.cards = cards.sorted(by: { $0.orderIndex < $1.orderIndex })
                }
            }
            .store(in: &subscriptions)
    }
    
    func delete(card: Card) {
        storage.delete(card: card)
    }
    
    func clear() {
        storage.clear()
    }
    
    func reorder() {
        guard cards.count > 1 else { return }
        storage.reorder(cards: cards)
    }
    
    func getOrderIndex(_ card: Card) -> UInt {
        guard let lastCard = cards.last else { return 0 }
        if cards.contains(where: { $0.id == card.id }) {
            return card.orderIndex
        }
        return lastCard.orderIndex + 1
    }
    
    private func configureObservers() {
        let center = NotificationCenter.default
        center
            .publisher(for: Storage.notificationName)
            .sink { [weak self] _ in self?.loadAll() }
            .store(in: &subscriptions)
        center
            .publisher(for: UIApplication.willTerminateNotification)
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.needReorder {
                    self.reorder()
                }
            }
            .store(in: &subscriptions)
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
    
    @inlinable func makeNumber(_ string: String) -> String {
        string.replacingOccurrences(of: " ", with: "")
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

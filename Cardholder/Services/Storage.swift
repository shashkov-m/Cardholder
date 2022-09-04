//
//  Storage.swift
//  Cardholder
//
//  Created by Max Shashkov on 01.06.2022.
//

import Foundation
import Combine
import KeychainSwift

final class Storage {
    private let keychain = KeychainSwift()
    private let prefix = "shashkov"
    private let center = NotificationCenter.default
    static let notificationName = Notification.Name("StorageUpdated")
    private var subscriptions = Set<AnyCancellable>()
    
    func save(card: Card, notify: Bool = true) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(card)
        guard let data = data else { return }
        keychain.set(data, forKey: makeKey(card.id.uuidString), withAccess: .accessibleWhenUnlocked)
        if notify { center.post(name: Storage.notificationName, object: nil) }
    }
    
    func loadAll() -> AnyPublisher<[Card], Never> {
        keychain.allKeys
            .publisher
            .filter { $0.contains(prefix) }
            .compactMap { keychain.getData($0) }
            .decode(type: Card.self, decoder: JSONDecoder())
            .replaceError(with: Card.empty())
            .collect()
            .eraseToAnyPublisher()
    }
    
    func delete(card: Card) {
        keychain.delete(makeKey(card.id.uuidString))
        reorder(deleteIndex: card.orderIndex)
        center.post(name: Storage.notificationName, object: nil)
    }
    
    func clear() {
        keychain.clear()
        center.post(name: Storage.notificationName, object: nil)
    }
    
    func reorder(deleteIndex: UInt) {
        loadAll()
            .flatMap(maxPublishers: .max(1)) { $0.publisher }
            .map { card -> Card in
                guard deleteIndex > card.orderIndex else { return card }
                var card = card
                card.decrementOrderIndex()
                return card
            }
            .sink { [weak self] card in
                self?.save(card: card)
            }
            .store(in: &subscriptions)
    }
    
    func reorder(cards: [Card]) {
        loadAll()
            .flatMap(maxPublishers: .max(1)) { $0.publisher }
            .compactMap { card -> Card? in
                guard let firstIndex = cards.firstIndex(of: card) else { return nil }
                let index = UInt(firstIndex)
                var card = card
                card.changeOrderIndex(index)
                return card
            }
            .sink { [weak self] card in
                self?.save(card: card, notify: false)
            }
            .store(in: &subscriptions)
    }
    
    private func makeKey(_ uuidString: String) -> String {
        "\(prefix)_\(uuidString)"
    }
}

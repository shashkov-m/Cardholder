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
    
    func save(card: Card) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(card)
        guard let data = data else { return }
        keychain.set(data, forKey: makeKey(card.id.uuidString), withAccess: .accessibleWhenUnlocked)
        center.post(name: Storage.notificationName, object: nil)
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
        center.post(name: Storage.notificationName, object: nil)
    }
    
    func clear() {
        keychain.clear()
        center.post(name: Storage.notificationName, object: nil)
    }
    
    private func makeKey(_ uuidString: String) -> String {
        "\(prefix)_\(uuidString)"
    }
}

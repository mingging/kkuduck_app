//
//  SubscriptionRepository.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/24.
//

import Foundation

protocol SubscriptionRepositoryType {
    func subscriptions() -> [Subscription]
    func save(subscription: Subscription)
    func delete(subscription: Subscription)
}

public final class SubscriptionRepository: SubscriptionRepositoryType {

    static let shared = SubscriptionRepository()

    private init() { }

    // MARK: -

    private let fileName: String = "writeSubscription.plist"

    private var fileURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documents.appendingPathComponent(fileName)
    }

    private lazy var encoder: PropertyListEncoder = {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        return encoder
    }()

    // MARK: -

    func subscriptions() -> [Subscription] {
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
        }
        if let data = FileManager.default.contents(atPath: fileURL.path),
           let subscriptions = try? PropertyListDecoder().decode([Subscription].self, from: data) {
            return subscriptions
        } else {
            return []
        }
    }

    func save(subscription: Subscription) {
        var subscriptions = subscriptions()
        subscriptions.append(subscription)
        if let data = try? encoder.encode(subscriptions) {
            try! data.write(to: fileURL)
        }
    }

    func update(endDate: Date, for subscription: Subscription) {
        var subscriptions = subscriptions()
        guard let index = subscriptions.firstIndex(of: subscription) else { return }
        subscriptions[index].endDate = endDate
        if let data = try? encoder.encode(subscriptions) {
            try! data.write(to: fileURL)
        }
    }

    func delete(subscription: Subscription) {
        var subscriptions = subscriptions()
        if let index = subscriptions.firstIndex(of: subscription) {
            subscriptions.remove(at: index)
        }
        if let data = try? encoder.encode(subscriptions) {
            try! data.write(to: fileURL)
        }
    }

}

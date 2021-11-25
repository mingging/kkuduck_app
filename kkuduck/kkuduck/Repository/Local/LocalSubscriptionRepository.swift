//
//  LocalSubscriptionRepository.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/24.
//

import Foundation

struct LocalSubscriptionRepository: SubscriptionRepositoryType {

    private static let fileName = "writeSubscription.plist"

    static var fileURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documents.appendingPathComponent(fileName)
    }
    static var plist: NSMutableArray? {
        NSMutableArray(contentsOfFile: fileURL.path)
    }

    private static func load() -> [Subscription] {
        let decoder = PropertyListDecoder()
        guard let data = try? Data(contentsOf: fileURL),
              let subscriptions = try? decoder.decode([Subscription].self, from: data) else { return [] }
        return subscriptions
    }

    // MARK: -

    static func items(completion: @escaping ([Subscription]?) -> Void) {
        completion(load())
    }

    static func save(subscription: Subscription) {
        var subscriptions = load()
        subscriptions.append(subscription)

        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        if let data = try? encoder.encode(subscriptions) {
            try! data.write(to: fileURL)
        }

    }

    static func delete(at index: Int) {
        var subscriptions = load()
        subscriptions.remove(at: index)
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        if let data = try? encoder.encode(subscriptions) {
            try! data.write(to: fileURL)
        }
    }

}

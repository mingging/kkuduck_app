//
//  SubscriptionRepository.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/24.
//

import Foundation

protocol SubscriptionRepositoryType {
    static func items(completion: @escaping ([Subscription]?) -> Void)
    static func save(subscription: Subscription)
    static func delete(at: Int)
}

protocol DefaultSubscriptionRepositoryType {
    func items(completion: @escaping ([Subscription]?) -> Void)
}

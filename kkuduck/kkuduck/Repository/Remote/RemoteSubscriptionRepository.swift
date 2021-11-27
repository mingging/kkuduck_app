//
//  RemoteSubscriptionRepository.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/24.
//

import Foundation
import Alamofire

struct RemoteSubscriptionRepository: SubscriptionRepositoryType {
    static func items(completion: @escaping ([Subscription]?) -> Void) {
        AF.request(SubscriptionRequest.get).responseDecodable { response in
            completion(response.value)
        }
    }

    static func save(subscription: Subscription) {
//        AF.request(SubscriptionRequest.post)
    }

    static func delete(at index: Int) {
//        AF.request(SubscriptionRequest.delete)
    }

}

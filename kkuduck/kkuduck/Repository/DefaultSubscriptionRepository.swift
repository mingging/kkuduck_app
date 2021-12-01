//
//  RemoteSubscriptionRepository.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/24.
//

import Foundation
import Alamofire

public final class DefaultSubscriptionRepository {

    static let shared = DefaultSubscriptionRepository()

    private init() { }

    // MARK: -

    func defaultSubscriptions(completion: @escaping ([DefaultSubscription]?) -> Void) {
        let endpoint = DefaultSubscriptionRequest.items
        AF.request(endpoint).responseDecodable(of: DefaultSubscriptionResponse.self) { response in
            completion(response.value?.defaultSubscriptions)
        }
    }

}

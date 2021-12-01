//
//  SubscriptionStoreRequest.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/24.
//

import Foundation
import Alamofire

// MARK: - DefaultSubscriptionRequest

enum DefaultSubscriptionRequest {
    case items
}

extension DefaultSubscriptionRequest: URLRequestConvertible {

    var baseURL: URL {
        return URL(string: "http://20.196.199.127:8000")!
    }

    var method: HTTPMethod {
        switch self {
        case .items:
            return .get
        }
    }

    var path: String {
        switch self {
        case .items:
            return "/defaultsubscriptions/"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        return request
    }

}

// MARK: - DefaultSubscriptionResponse

struct DefaultSubscriptionResponse: Decodable {

    let defaultSubscriptions: [DefaultSubscription]

    enum CodingKeys: String, CodingKey {
        case defaultSubscriptions = "data"
    }

}

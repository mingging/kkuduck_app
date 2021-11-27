//
//  SubscriptionStoreRequest.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/24.
//

import Foundation
import Alamofire

enum SubscriptionRequest {
    case get
    case post([String: String])
    case put([String: String])
    case delete
}

extension SubscriptionRequest: URLRequestConvertible {

    var baseURL: URL {
        return URL(string: "")!
    }

    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        }
    }

    var path: String {
        switch self {
        case .get:
            return "get"
        case .post:
            return "post"
        case .put:
            return "put"
        case .delete:
            return "delete"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        switch self {
        case .get:
            break
        case let .post(parameters):
            request = try JSONParameterEncoder().encode(parameters, into: request)
        case .put:
            break
        case .delete:
            break
        }
        return request
    }

}

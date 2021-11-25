//
//  DefaultSubscriptionStoreRequest.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/24.
//

import Foundation
import Alamofire

enum DefaultSubscriptionRequest {
    case get
}

extension DefaultSubscriptionRequest: URLRequestConvertible {

    var baseURL: URL {
        return URL(string: "")!
    }

    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        }
    }

    var path: String {
        switch self {
        case .get:
            return "get"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        return request
    }

}

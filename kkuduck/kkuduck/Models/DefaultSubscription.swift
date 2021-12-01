//
//  DefaultSubscription.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/29.
//

import Foundation

public struct DefaultSubscription: Decodable {

    struct Plan: Decodable {
        /// 구독 플랜 이름
        let name: String
        /// 구독 플랜 가격
        let price: Int
        /// 구독 플랜 주기
        let cycle: Cycle

        enum CodingKeys: String, CodingKey {
            case name = "plan_name"
            case price = "plan_price"
            case cycle
        }
    }

    /// 구독 서비스 이름
    let name: String
    /// 구독 플랜
    let plans: [Plan]
    /// 구독 서비스 이미지
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case name = "service_name"
        case plans
        case imageUrl = "image_url"
    }

}

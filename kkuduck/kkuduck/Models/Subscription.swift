//
//  Subscription.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/16.
//

import Foundation

public struct Subscription: Codable, Equatable {
    /// 구독 서비스 이름
    let serviceName: String
    /// 구독 플랜 이름
    let planName: String
    /// 구독 플랜 가격
    let planPrice: Int
    /// 구독 결제 주기
    let cycle: Cycle
    /// 서비스 사용 인원
    let shareCount: Int
    /// 구독 시작일
    let startDate: Date
    /// 구독 만료일
    let endDate: Date?
    /// 구독 서비스 이미지
    let imageUrl: String
    /// 서비스 사용 아이디
    let shareId: String?

    enum CodingKeys: String, CodingKey {
        case serviceName
        case planName
        case planPrice
        case cycle
        case shareCount
        case startDate
        case endDate
        case imageUrl
        case shareId
    }
}

public enum Cycle: String, Codable, CaseIterable {
    case month = "월"
    case year = "년"

    enum CodingKeys: String, CodingKey {
        case month = "월"
        case year = "년"
    }
}

//
//  Subscription.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/16.
//

// 1. db 에서 가져올 때 아예 영어 버전을 따로 가져오게끔
// 2. 로컬라이징을 프론트에서 다 준비해놓고 (백에서는 무조건 영문으로 받느다, 로컬라이즈 가보면 키 밸루 있는데 키를 영문으로 받는다 프로그램은 영문을 기준으로 짜놓고 로컬라이즈 키에서 바꾸는 거)
import Foundation

public struct Subscription: Codable, Equatable {
    /// 구독 서비스 이름
    let serviceName: String
    /// 구독 플랜 이름
    let planName: String
    /// 구독 플랜 가격, 원래 let 이었는데 var로 변경함. 연산프로퍼티로 바꾸기
    var planPrice: Int
    /// 구독 결제 주기
    let cycle: Cycle
    /// 서비스 사용 인원
    let shareCount: Int
    /// 구독 시작일
    let startDate: Date
    /// 구독 만료일
    var endDate: Date?
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

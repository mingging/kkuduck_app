//
//  En_Subscription.swift
//  kkuduck
//
//  Created by jo on 2021/12/12.
//

import Foundation

public struct Subscription: Codable, Equatable {
    /// 구독 서비스 이름
    let serviceName: String.localied
    /// 구독 플랜 이름
    let planName: String
    /// 구독 플랜 가격, 원래 let 이었음..연산프로퍼티로 바꾸
    let planPrice: Int
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

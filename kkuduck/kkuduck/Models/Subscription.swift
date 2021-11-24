//
//  Subscription.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/16.
//

import Foundation

// MARK: - Subscription

struct Subscription {
    let name: String
    let price: Int
    let cycle: String
    let startDate: Date
    let imageUrl: String
}

// MARK: - DefaultSubscription

struct DefaultSubscription: Decodable {
    let name: String
    let plans: [Plan]
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case name = "serviceName"
        case plans
        case imageUrl
    }
}

struct Plan: Decodable {
    let name: String
    let price: Int
    let cycle: String
}

// MARK: - SampleData

extension DefaultSubscription {
    static let sampleData = """
    [
      {
        "serviceName": "플로",
        "plans": [
          {
            "name": "무제한+오프라인",
            "price": 11000,
            "cycle": "월"
          },
          {
            "name": "무제한",
            "price": 8000,
            "cycle": "월"
          },
          {
            "name": "300회",
            "price": 4800,
            "cycle": "월"
          },
          {
            "name": "모바일 무제한",
            "price": 7000,
            "cycle": "월"
          }
        ],
        "imageUrl": "flo.png"
      },
      {
        "serviceName": "밀리의 서재",
        "plans": [
          {
            "name": "전자책(월)",
            "price": 9900,
            "cycle": "월"
          },
          {
            "name": "전자책(년)",
            "price": 99000,
            "cycle": "년"
          },
          {
            "name": "종이책(월)",
            "price": 15900,
            "cycle": "월"
          },
          {
            "name": "종이책(년)",
            "price": 183000,
            "cycle": "년"
          }
        ],
        "imageUrl": "millie.png"
      },
      {
        "serviceName": "리디북스 셀렉트",
        "plans": [
          {
            "name": "정기구독",
            "price": 4900,
            "cycle": "월"
          }
        ],
        "imageUrl": "ridibooks.png"
      },
      {
        "serviceName": "카카오페이지",
        "plans": [
          {
            "name": "정기결제1",
            "price": 3000,
            "cycle": "월"
          },
          {
            "name": "정기결제2",
            "price": 5000,
            "cycle": "월"
          },
          {
            "name": "정기결제3",
            "price": 10000,
            "cycle": "월"
          },
          {
            "name": "정기결제4",
            "price": 30000,
            "cycle": "월"
          },
          {
            "name": "정기결제5",
            "price": 50000,
            "cycle": "월"
          },
          {
            "name": "정기결제6",
            "price": 100000,
            "cycle": "월"
          }
        ],
        "imageUrl": "kakaopage.png"
      },
      {
        "serviceName": "예스24",
        "plans": [
          {
            "name": "스탠다드",
            "price": 5500,
            "cycle": "월"
          },
          {
            "name": "프리미엄",
            "price": 7700,
            "cycle": "월"
          },
          {
            "name": "북클럽XFLO",
            "price": 9900,
            "cycle": "월"
          }
        ],
        "imageUrl": "yes24.png"
      },
      {
        "serviceName": "카카오톡 이모티콘",
        "plans": [
          {
            "name": "정기구독",
            "price": 3900,
            "cycle": "월"
          }
        ],
        "imageUrl": "kakaoemoticon.png"
      },
      {
        "serviceName": "쿠팡 로켓와우",
        "plans": [
          {
            "name": "정기구독",
            "price": 2900,
            "cycle": "월"
          }
        ],
        "imageUrl": "coupang.png"
      },
      {
        "serviceName": "네이버 멤버쉽 플러스",
        "plans": [
          {
            "name": "정기구독",
            "price": 4900,
            "cycle": "월"
          }
        ],
        "imageUrl": "naver.png"
      }
    ]
    """.data(using: .utf8)!
}

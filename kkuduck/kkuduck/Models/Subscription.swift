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
        "imageUrl": "https://is2-ssl.mzstatic.com/image/thumb/Purple126/v4/5d/4f/ef/5d4fef03-9570-9eff-6fd1-866ff73c3d83/AppIcon-0-1x_U007emarketing-5-0-85-220.png/460x0w.png"
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
        "imageUrl": "https://is5-ssl.mzstatic.com/image/thumb/Purple126/v4/fe/ff/9e/feff9ebc-3dd5-b055-65f2-df65dc128064/AppIcon-0-0-1x_U007emarketing-0-0-0-4-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.webp"
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
        "imageUrl": "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/14/4d/0b/144d0b8e-3d64-ec7e-4f42-6412da0a3e2b/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.webp"
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
        "imageUrl": "https://is5-ssl.mzstatic.com/image/thumb/Purple125/v4/e7/f0/33/e7f0333d-31c0-9de7-0fb8-f96d613aa686/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.webp"
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
        "imageUrl": "https://is5-ssl.mzstatic.com/image/thumb/Purple116/v4/21/08/55/2108557d-e74a-82d0-338e-92c433944cc2/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/460x0w.webp"
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
        "imageUrl": "https://is4-ssl.mzstatic.com/image/thumb/Purple116/v4/8f/b8/23/8fb823fb-c9cf-dbee-1201-38d0dc302cef/AppIcon-0-0-1x_U007emarketing-0-0-0-10-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.webp"
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
        "imageUrl": "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/82/0c/74/820c74b8-cdd3-91cb-8a90-a3180c2dc530/AppIcon-0-0-1x_U007emarketing-0-0-0-10-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.webp"
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
        "imageUrl": "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/69/83/bd/6983bd7a-0cca-4125-628b-2d061e998c55/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/460x0w.webp"
      }
    ]
    """.data(using: .utf8)!
}

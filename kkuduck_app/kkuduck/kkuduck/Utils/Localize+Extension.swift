//
//  Localize+Extension.swift
//  kkuduck
//
//  Created by jo on 2021/12/10.
//

import Foundation

// localize String
extension String {
 var localized: String {
     return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "\(self)_comment")
 }
//  func localized(_ args: [CVarArg]) -> String {
//    return localized(args)
//  }
 func localized(_ args: CVarArg...) -> String {
   return String(format: localized, args)
 }
}

// extension String {
//    // formatting text for currency textField
//    func currencyFormatting() -> String {
//        if let value = Double(self) {
//            let formatter = NumberFormatter()
//            formatter.numberStyle = .currency
//            formatter.maximumFractionDigits = 2
//            formatter.minimumFractionDigits = 2
//            if let str = formatter.string(for: value) {
//                return str
//            }
//        }
//        return ""
//    }
// }

// 다른 구조체의 인스턴스를 가져와서 이 확장에 넣으려면? 그렇게 하는 게 더 복잡하다고함

class Account {

    static let dollarExchangeRate: Double = 1000.0
    var won: Subscription
    // 구조체나 클래스를 타입으로 쓰려고

    init(won: Subscription) {
        self.won = won
        // account 생성할 때 init 함수에서 생성해야함 옵셔널로
    }

    var dollarValue: Double {
        get {
            return Double(won.planPrice) / Self.dollarExchangeRate
        }
        set {
            won.planPrice = Int(newValue * Account.dollarExchangeRate)
            print("잔액을 \(newValue) 달러로 변경중입니다")
        }
    }
}

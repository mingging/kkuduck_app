//
//  Int+Extension.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/12/03.
//

import Foundation

extension Int {

    // TODO: Localization
    var currencyString: String {
        let formatter = NumberFormatter()
//        formatter.locale = Locale(identifier: "ko_KR")
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
//        return formatter.string(from: self as NSNumber)! + "원"

        return formatter.string(from: self as NSNumber)! + "원".localized

    }

}

/*
 extension String {
     // formatting text for currency textField
     func currencyFormatting() -> String {
         if let value = Double(self) {
             let formatter = NumberFormatter()
             formatter.numberStyle = .currency
             formatter.maximumFractionDigits = 2
             formatter.minimumFractionDigits = 2
             if let str = formatter.string(for: value) {
                 return str
             }
         }
         return ""
     }
 }
 */

/* Localization reference
 let price = 149.95 as NSNumber
 let formatter = NumberFormatter()
 formatter.numberStyle = .currency
 formatter.currencyCode = "EUR"
 formatter.locale = Locale.current
 formatter.string(from: price)
 label.text = formatter.string(from: price)
 */

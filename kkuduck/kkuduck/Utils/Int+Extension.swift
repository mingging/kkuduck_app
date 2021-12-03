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
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        return formatter.string(from: self as NSNumber)! + "원"
    }

}

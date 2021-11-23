//
//  CustomDateFormatter.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/23.
//

import Foundation

struct CustomDateFormatter {

    private static let dateFormat = "yyyy.MM.dd"
    private static var dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }()

    static func string(from: Date) -> String? {
        return dateFormatter.string(from: from)
    }

    static func date(from: String) -> Date? {
        return dateFormatter.date(from: from)
    }

}

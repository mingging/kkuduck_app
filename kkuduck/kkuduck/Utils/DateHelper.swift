//
//  DateHelper.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/23.
//

import Foundation

struct DateHelper {

    private static let dateFormat = "yyyy.MM.dd"
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }()

    // MARK: -

    static func string(from: Date) -> String? {
        return dateFormatter.string(from: from)
    }

    static func date(from: String) -> Date? {
        return dateFormatter.date(from: from)
    }

    /// 주어진 구독 시작일과 결제 주기에 해당하는 다음 결제 예정일을 계산합니다.
    ///
    /// - Parameter startDate: 구독 시작일
    /// - Parameter component: 결제 주기
    /// - Returns: 다음 결제 예정일
    static func nextSubscriptionDate(from startDate: Date, matching cycle: Cycle) -> Date? {
        let today = Date()
        if startDate > today {
            return startDate
        }
        let startDateComponents = Calendar.current.dateComponents(cycle.matchingComponents, from: startDate)
        return Calendar.current.nextDate(
            after: today,
            matching: startDateComponents,
            matchingPolicy: .previousTimePreservingSmallerComponents,
            repeatedTimePolicy: .first,
            direction: .forward
        )
    }

}

// MARK: - Cycle

fileprivate extension Cycle {
    var matchingComponents: Set<Calendar.Component> {
        switch self {
        case .month:
            return [.day]
        case .year:
            return [.month, .day]
        }
    }
}

// MARK: - DateComponents + Comparable

extension DateComponents: Comparable {
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        guard let lhsDate = Calendar.current.date(from: lhs),
              let rhsDate = Calendar.current.date(from: rhs) else {
                  assertionFailure("A date which matches the components couldn't be found")
                  return false
              }
        return lhsDate < rhsDate
    }

    public static func == (lhs: DateComponents, rhs: DateComponents) -> Bool {
        guard let lhsDate = Calendar.current.date(from: lhs),
              let rhsDate = Calendar.current.date(from: rhs) else {
                  assertionFailure("A date which matches the components couldn't be found")
                  return false
              }
        return lhsDate == rhsDate
    }
}

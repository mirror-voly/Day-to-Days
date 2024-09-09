//
//  DateCalculator.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import Foundation

final class DateCalculator {
    static func daysFrom(this: Date) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: this, to: currentDate)
        let daysCounter = components.day ?? 0
        return String(abs(daysCounter))
    }

    static func determineFutureOrPast(this: Date) -> String {
        let currentDate = Date()
        let description = this < currentDate ? "gone" : "left"
        return description
    }

    static func findDateType(_ dateType: Event.DateType) -> Double? {
        guard let index = Event.DateType.allCases.firstIndex(of: dateType) else { return nil }
        return Double(index)
    }
}

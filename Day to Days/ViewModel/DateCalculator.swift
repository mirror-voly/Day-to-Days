//
//  DateCalculator.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import Foundation

final class DateCalculator {

    static func findIndexForThis(dateType: DateType) -> Double { // for slider value
        guard let index = DateType.allCases.firstIndex(of: dateType) else { return 0 }
        return Double(index)
    }

    static func determineFutureOrPastForThis(date: Date) -> TimeStateType {
        let currentDate = Date()
        let calendar = Calendar.current
        if calendar.isDate(date, inSameDayAs: currentDate) {
            return .present
        } else {
            return date < currentDate ? .past : .future
        }
    }
    // MARK: - Date counters
    static func daysFrom(date: Date) -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date, to: currentDate)
        let daysCounter = components.day ?? 0
        return abs(daysCounter)
    }

    static func weeksFrom(date: Date) -> [DateType: String] {
        let days = daysFrom(date: date)
        let weakCounter = days / 7
        let daysCounter = days % 7
        return [.week: String(weakCounter), .day: String(daysCounter)]
    }

    static func monthsFrom(date: Date) -> [DateType: String] {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.month, .day], from: date, to: today)
        let months = abs(components.month ?? 0)
        let days = abs(components.day ?? 0)
        let weeks = abs(days / 7)
        return [.month: String(months), .week: String(weeks), .day: String(days)]
    }

    static func yearsFrom(date: Date) -> [DateType: String] {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: date, to: today)
        let years = abs(components.year ?? 0)
        let months = abs(components.month ?? 0)
        let days = abs(components.day ?? 0)
        let weeks = abs(days / 7)
        return [.year: String(years), .month: String(months), .week: String(weeks), .day: String(days)]
    }

    static func dateInfoForThis(date: Date, dateType: DateType) -> [DateType: String] {
        let returnDate: [DateType: String]
        switch dateType {
        case .day:
            returnDate = [.day: String(daysFrom(date: date))]
        case .week:
            returnDate = weeksFrom(date: date)
        case .month:
            returnDate = monthsFrom(date: date)
        case .year:
            returnDate = yearsFrom(date: date)
        }
        return returnDate
    }

    static func findFirstDateFromTheTopFor(date: Date, dateType: DateType) -> String { // gives only top one
        let currentDate = dateInfoForThis(date: date, dateType: dateType)
        if let value = currentDate[dateType] {
            return value
        }
        return ""
    }
}

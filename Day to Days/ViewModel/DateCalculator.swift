//
//  DateCalculator.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import Foundation

final class DateCalculator {

    static func daysFrom(date: Date) -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date, to: currentDate)
        let daysCounter = components.day ?? 0
        return abs(daysCounter)
    }

    static func weeksFrom(date: Date) -> [Event.DateType: String] {
        let days = daysFrom(date: date)
        let weakCounter = days / 7
        let daysCounter = days % 7
        return [.weak: String(weakCounter), .day: String(daysCounter)]
    }

    static func monthsFrom(from: Date) -> [Event.DateType: String] {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.month, .day], from: from, to: today)
        let months = abs(components.month ?? 0)
        let days = abs(components.day ?? 0)
        let weeks = abs(days / 7)
        return [.month: String(months), .weak: String(weeks), .day: String(days)]
    }

    static func allTimeInfoUntilToday(from: Date) -> [Event.DateType: String] {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: from, to: today)
        let years = abs(components.year ?? 0)
        let months = abs(components.month ?? 0)
        let days = abs(components.day ?? 0)
        let weeks = abs(days / 7)
        return [.year: String(years), .month: String(months), .weak: String(weeks), .day: String(days)]
    }

    static func presentInfoFor(chosenDate: Date, dateType: Event.DateType) -> [Event.DateType: String] {
        let date: [Event.DateType: String]
        switch dateType {
        case .day:
            date = [.day: String(daysFrom(date: chosenDate))]
        case .weak:
            date = weeksFrom(date: chosenDate)
        case .month:
            date = monthsFrom(from: chosenDate)
        case .year:
            date = allTimeInfoUntilToday(from: chosenDate)
        }
        return date
    }

    static func findBiggestAllowedDateFor(event: Event) -> String {
        let currentDate = presentInfoFor(chosenDate: event.date, dateType: event.dateType)
        if let value = currentDate[event.dateType] {
            return value
        }
        return ""
    }

    static func determineFutureOrPast(this: Date) -> String {
        let currentDate = Date()
        let description = this < currentDate ? "passed" : "left"
        return description
    }

    static func findDateType(_ dateType: Event.DateType) -> Double? {
        guard let index = Event.DateType.allCases.firstIndex(of: dateType) else { return nil }
        return Double(index)
    }
}

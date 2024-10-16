//
//  DateDifferenceCalculator.swift
//  Day to Days
//
//  Created by mix on 30.09.2024.
//

import Foundation

final class DateDifferenceCalculator {

    private let currentDate = Date()
    private let calendar = Calendar.current

    func daysFrom(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date, to: Date())
        return abs(components.day ?? 0)
    }

    func weeksFrom(date: Date) -> [DateType: String] {
            let daysSum = daysFrom(date: date)
            let weeks = daysSum / 7
            let days = daysSum % 7
            return [.week: String(weeks), .day: String(days)]
        }

    func monthsFrom(date: Date) -> [DateType: String] {
        let components = calendar.dateComponents([.month, .day], from: date, to: currentDate)
        let months = abs(components.month ?? 0)
        let daysLeft = abs(components.day ?? 0)
        let weeks = abs(daysLeft / 7)
        let days = abs(daysLeft % 7)
        return [.month: String(months), .week: String(weeks), .day: String(days)]
    }

    func yearsFrom(date: Date) -> [DateType: String] {
        let components = calendar.dateComponents([.year, .month, .day], from: date, to: currentDate)
        let years = abs(components.year ?? 0)
        let months = abs(components.month ?? 0)
        let daysLeft = abs(components.day ?? 0)
        let weeks = abs(daysLeft / 7)
        let days = abs(daysLeft % 7)
        return [.year: String(years), .month: String(months), .week: String(weeks), .day: String(days)]
    }
}

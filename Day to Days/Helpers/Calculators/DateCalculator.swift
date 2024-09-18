//
//  DateCalculator.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import Foundation

final class DateCalculator {
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
        let components = calendar.dateComponents([.day, .hour], from: currentDate, to: date)
        // TODO: Should we check hours on last day too?
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

    static func allTimeDataFor(event: Event) -> [String: String] {
        let timeState = determineFutureOrPastForThis(date: event.date)
        let dateNumber = findFirstDateFromTheTopFor(date: event.date, dateType: event.dateType)
        let localizedDateType = TimeUnitLocalizer.localizeIt(for: dateNumber, unit: event.dateType.label)
        let localizedTimeState = TimeUnitLocalizer.localizeTimeState(for: dateNumber, state: timeState, dateType: event.dateType)
        return ["timeState": timeState.label, "dateNumber": dateNumber, "localizedDateType": localizedDateType, "localizedTimeState": localizedTimeState]
    }

    static func getLocalizedTimeState(event: Event) -> String {
        let timeState = DateCalculator.determineFutureOrPastForThis(date: event.date)
        let dateNumber = findFirstDateFromTheTopFor(date: event.date, dateType: event.dateType)
        let localizedTimeState = TimeUnitLocalizer.localizeTimeState(for: dateNumber, state: timeState, dateType: event.dateType)
        return localizedTimeState
    }
}

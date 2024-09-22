//
//  WidgetViewModel.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.


import SwiftUI

@Observable
final class WidgetViewModel {
    private (set) var localizedTimeState: String = ""
    private (set) var number: String = ""
    private (set) var localizedDateType: String = ""
    
    func setTimeData(event: EventWidget) {
        let timeData = allTimeDataFor(date: event.date, dateType: event.dateType)
        if let localizedTimeState = timeData["localizedTimeState"] {
            self.localizedTimeState = localizedTimeState
        }
        if let number = timeData["dateNumber"] {
            self.number = number
        }
        if let localizedDateType = timeData["localizedDateType"] {
            if timeData ["timeState"] != TimeStateType.present.label {
                self.localizedDateType = localizedDateType
            }
        }
    }
    
    private func determineFutureOrPastForThis(date: Date) -> TimeStateType {
        let currentDate = Date()
        let calendar = Calendar.current
        if calendar.isDate(date, inSameDayAs: currentDate) {
            return .present
        } else {
            return date < currentDate ? .past : .future
        }
    }
    // MARK: - Date counters
    private func daysFrom(date: Date) -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour], from: currentDate, to: date)
        let daysCounter = components.day ?? 0
        return abs(daysCounter)
    }
    
    private func weeksFrom(date: Date) -> [DateType: String] {
        let days = daysFrom(date: date)
        let weakCounter = days / 7
        let daysCounter = days % 7
        return [.week: String(weakCounter), .day: String(daysCounter)]
    }
    
    private func monthsFrom(date: Date) -> [DateType: String] {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.month, .day], from: date, to: today)
        let months = abs(components.month ?? 0)
        let days = abs(components.day ?? 0)
        let weeks = abs(days / 7)
        return [.month: String(months), .week: String(weeks), .day: String(days)]
    }
    
    private func yearsFrom(date: Date) -> [DateType: String] {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: date, to: today)
        let years = abs(components.year ?? 0)
        let months = abs(components.month ?? 0)
        let days = abs(components.day ?? 0)
        let weeks = abs(days / 7)
        return [.year: String(years), .month: String(months), .week: String(weeks), .day: String(days)]
    }
    
    func dateInfoForThis(date: Date, dateType: DateType) -> [DateType: String] {
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
    
    func findFirstDateFromTheTopFor(date: Date, dateType: DateType) -> String { // gives only top one
        let currentDate = dateInfoForThis(date: date, dateType: dateType)
        if let value = currentDate[dateType] {
            return value
        }
        return ""
    }
    
    private func getRussianYearForm(for count: Int) -> String {
        return count % 10 == 1 && count % 100 != 11 ? "год" :
        (count % 10 >= 2 && count % 10 <= 4 && (count % 100 < 10 || count % 100 >= 20) ? "года" : "лет")
    }
    
    private func getRussianMonthForm(for count: Int) -> String {
        return count % 10 == 1 && count % 100 != 11 ? "месяц" :
        (count % 10 >= 2 && count % 10 <= 4 && (count % 100 < 10 || count % 100 >= 20) ? "месяца" : "месяцев")
    }
    
    private func getRussianWeekForm(for count: Int) -> String {
        return count % 10 == 1 && count % 100 != 11 ? "неделя" :
        (count % 10 >= 2 && count % 10 <= 4 && (count % 100 < 10 || count % 100 >= 20) ? "недели" : "недель")
    }
    
    private func getRussianDayForm(for count: Int) -> String {
        return count % 10 == 1 && count % 100 != 11 ? "день" :
        (count % 10 >= 2 && count % 10 <= 4 && (count % 100 < 10 || count % 100 >= 20) ? "дня" : "дней")
    }
    
    private func getRussianLocalization(for count: Int, unit: String) -> String {
        switch unit {
        case "годы":
            return getRussianYearForm(for: count)
        case "месяцы":
            return getRussianMonthForm(for: count)
        case "недели":
            return getRussianWeekForm(for: count)
        case "дни":
            return getRussianDayForm(for: count)
        default:
            return unit
        }
    }
    
    private func getEnglishLocalization(for count: Int, unit: String) -> String {
        switch unit {
        case "years":
            return count == 1 ? "year" : "years"
        case "months":
            return count == 1 ? "month" : "months"
        case "weeks":
            return count == 1 ? "week" : "weeks"
        case "days":
            return count == 1 ? "day" : "days"
        default:
            return unit
        }
    }
    
    func localizeIt(for count: String, unit: String) -> String {
        guard let countInt = Int(count) else { return "error" }
        let absCount = abs(countInt)
        let languageCode = Locale.current.language.languageCode?.identifier
        switch languageCode {
        case "ru":
            return getRussianLocalization(for: absCount, unit: unit)
        case "en":
            return getEnglishLocalization(for: absCount, unit: unit)
        default:
            return unit
        }
    }
    
    private func localizeTimeStateInRussian(for count: Int, state: TimeStateType, dateType: DateType) -> String {
        switch state {
        case .future:
            return dateType == .week ? (count == 1 ? "осталaсь" : "осталось") : (count == 1 ? "остался" : "осталось")
        case .past:
            return dateType == .week ? (count == 1 ? "прошла" : "прошло") : (count == 1 ? "прошел" : "прошло")
        case .present:
            return "сегодня"
        }
    }
    
    func localizeTimeState(for count: String, state: TimeStateType, dateType: DateType) -> String {
        guard let countInt = Int(count) else { return "error" }
        let languageCode = Locale.current.language.languageCode?.identifier
        if languageCode == "ru" {
            return localizeTimeStateInRussian(for: countInt, state: state, dateType: dateType)
        } else {
            return state.label
        }
    }
    
    func getLocalizedTimeState(date: Date, dateType: DateType) -> String {
        let timeState = determineFutureOrPastForThis(date: date)
        let dateNumber = findFirstDateFromTheTopFor(date: date, dateType: dateType)
        let localizedTimeState = localizeTimeState(for: dateNumber, state: timeState, dateType: dateType)
        return localizedTimeState
    }
    
    func allTimeDataFor(date: Date, dateType: DateType) -> [String: String] {
        let timeState = determineFutureOrPastForThis(date: date)
        let dateNumber = findFirstDateFromTheTopFor(date: date, dateType: dateType)
        let localizedDateType = localizeIt(for: dateNumber, unit: dateType.label)
        let localizedTimeState = localizeTimeState(for: dateNumber, state: timeState, dateType: dateType)
        return ["timeState": timeState.label, "dateNumber": dateNumber, "localizedDateType": localizedDateType, "localizedTimeState": localizedTimeState]
    }
}

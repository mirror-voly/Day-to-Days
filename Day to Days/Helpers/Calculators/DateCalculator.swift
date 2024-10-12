//
//  DateCalculator.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import Foundation

final class DateCalculator {
    private let dateDifferenceCalculator = DateDifferenceCalculator()
    private let dateLocalization = DateLocalization()
    private let timeStateDeterminer = TimeStateDeterminer()

    private func findFirstDateFromTheTopFor(date: Date, dateType: DateType) -> String {
        let currentDate = dateInfoForThis(date: date, dateType: dateType)
        guard let value = currentDate[dateType] else { return Constants.emptyString }
        return value
    }

    func dateInfoForThis(date: Date, dateType: DateType) -> [DateType: String] {
            let returnDate: [DateType: String]
            switch dateType {
            case .day:
                returnDate = [.day: String(dateDifferenceCalculator.daysFrom(date: date))]
            case .week:
                returnDate = dateDifferenceCalculator.weeksFrom(date: date)
            case .month:
                returnDate = dateDifferenceCalculator.monthsFrom(date: date)
            case .year:
                returnDate = dateDifferenceCalculator.yearsFrom(date: date)
            }
            return returnDate
        }

    func localizeIt(for count: String, dateType: DateType) -> String {
        guard let countInt = Int(count) else { return "error" }
        let absCount = abs(countInt)
        let languageCode = Locale.current.language.languageCode?.identifier
        switch languageCode {
        case "ru":
            return dateLocalization.getRussianLocalization(for: absCount, dateType: dateType)
        case "en":
            return dateLocalization.getEnglishLocalization(for: absCount, dateType: dateType)
        default:
            return dateType.label
        }
    }

    func getLocalizedTimeState(date: Date, dateType: DateType) -> String {
        let timeState = timeStateDeterminer.determineFutureOrPast(for: date)
        let dateNumber = findFirstDateFromTheTopFor(date: date, dateType: dateType)
        let localizedTimeState = dateLocalization.localizeTimeState(for: dateNumber,
                                                                    state: timeState, dateType: dateType)
        return localizedTimeState
    }

    func allTimeDataFor(date: Date, dateType: DateType) -> [TimeDataReturnType: String] {
        let timeState = timeStateDeterminer.determineFutureOrPast(for: date)
        let dateNumber = findFirstDateFromTheTopFor(date: date, dateType: dateType)
        let localizedDateType = localizeIt(for: dateNumber, dateType: dateType)
        let localizedTimeState = dateLocalization.localizeTimeState(for: dateNumber,
                                                                    state: timeState, dateType: dateType)
        return [.timeState: timeState.label, .dateNumber: dateNumber,
                .localizedDateType: localizedDateType, .localizedTimeState: localizedTimeState]
    }

    func getCurrentDayOfWeek() -> DayOfWeek {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: Date())
        let number = components.weekday ?? 1
        return DayOfWeek(rawValue: number) ?? .monday
    }
}

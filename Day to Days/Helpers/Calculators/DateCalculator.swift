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

    func localizeIt(for count: String, unit: String) -> String {
        guard let countInt = Int(count) else { return "error" }
        let absCount = abs(countInt)
        let languageCode = Locale.current.language.languageCode?.identifier
        switch languageCode {
        case "ru":
            return dateLocalization.getRussianLocalization(for: absCount, unit: unit)
        case "en":
            return dateLocalization.getEnglishLocalization(for: absCount, unit: unit)
        default:
            return unit
        }
    }

    func getLocalizedTimeState(date: Date, dateType: DateType) -> String {
        let timeState = timeStateDeterminer.determineFutureOrPast(for: date)
        let dateNumber = findFirstDateFromTheTopFor(date: date, dateType: dateType)
        let localizedTimeState = dateLocalization.localizeTimeState(for: dateNumber,
                                                                    state: timeState, dateType: dateType)
        return localizedTimeState
    }

    func allTimeDataFor(date: Date, dateType: DateType) -> [String: String] {
        let timeState = timeStateDeterminer.determineFutureOrPast(for: date)
        let dateNumber = findFirstDateFromTheTopFor(date: date, dateType: dateType)
        let localizedDateType = localizeIt(for: dateNumber, unit: dateType.label)
        let localizedTimeState = dateLocalization.localizeTimeState(for: dateNumber,
                                                                    state: timeState, dateType: dateType)
        return ["timeState": timeState.label, "dateNumber": dateNumber,
                "localizedDateType": localizedDateType, "localizedTimeState": localizedTimeState]
    }

    private func findFirstDateFromTheTopFor(date: Date, dateType: DateType) -> String {
        let currentDate = dateInfoForThis(date: date, dateType: dateType)
        if let value = currentDate[dateType] {
            return value
        }
        return ""
    }
}

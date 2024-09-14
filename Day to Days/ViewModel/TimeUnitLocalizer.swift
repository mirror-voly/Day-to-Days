//
//  TimeUnitLocalizer.swift
//  Day to Days
//
//  Created by mix on 12.09.2024.
//

import Foundation

final class TimeUnitLocalizer {
    
    private static func getRussianYearForm(for count: Int) -> String {
        return count % 10 == 1 && count % 100 != 11 ? "год" :
        (count % 10 >= 2 && count % 10 <= 4 && (count % 100 < 10 || count % 100 >= 20) ? "года" : "лет")
    }
    
    private static func getRussianMonthForm(for count: Int) -> String {
        return count % 10 == 1 && count % 100 != 11 ? "месяц" :
        (count % 10 >= 2 && count % 10 <= 4 && (count % 100 < 10 || count % 100 >= 20) ? "месяца" : "месяцев")
    }
    
    private static func getRussianWeekForm(for count: Int) -> String {
        return count % 10 == 1 && count % 100 != 11 ? "неделя" :
        (count % 10 >= 2 && count % 10 <= 4 && (count % 100 < 10 || count % 100 >= 20) ? "недели" : "недель")
    }
    
    private static func getRussianDayForm(for count: Int) -> String {
        return count % 10 == 1 && count % 100 != 11 ? "день" :
        (count % 10 >= 2 && count % 10 <= 4 && (count % 100 < 10 || count % 100 >= 20) ? "дня" : "дней")
    }
    
    private static func getRussianLocalization(for count: Int, unit: String) -> String {
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
    
    private static func getEnglishLocalization(for count: Int, unit: String) -> String {
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

    static func localizeIt(for count: String, unit: String) -> String {
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

    private static func localizeTimeStateInRussian(for count: Int, state: TimeStateType, dateType: DateType) -> String {
        let absCount = abs(count)
        switch state {
        case .future:
            return dateType == .week ? (count == 1 ? "осталaсь" : "осталось") : (count == 1 ? "остался" : "осталось")
        case .past:
            return dateType == .week ? (count == 1 ? "прошла" : "прошло") : (count == 1 ? "прошел" : "прошло")
        case .present:
            return "сегодня"
        }
    }

    static func localizeTimeState(for count: String, state: TimeStateType, dateType: DateType) -> String {
        guard let countInt = Int(count) else { return "error" }
        let languageCode = Locale.current.language.languageCode?.identifier
        if languageCode == "ru" {
            return localizeTimeStateInRussian(for: countInt, state: state, dateType: dateType)
        } else {
            return state.label
        }
    }
}
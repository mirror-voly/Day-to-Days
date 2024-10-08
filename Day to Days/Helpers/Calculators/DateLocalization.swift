//
//  DateLocalization.swift
//  Day to Days
//
//  Created by mix on 30.09.2024.
//

import Foundation

final class DateLocalization {
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

    func getRussianLocalization(for count: Int, dateType: DateType) -> String {
        switch dateType {
        case .year:
            return getRussianYearForm(for: count)
        case .month:
            return getRussianMonthForm(for: count)
        case .week:
            return getRussianWeekForm(for: count)
        case .day:
            return getRussianDayForm(for: count)
        }
    }

    func getEnglishLocalization(for count: Int, dateType: DateType) -> String {
        switch dateType {
        case .year:
            return count == 1 ? "year" : "years"
        case .month:
            return count == 1 ? "month" : "months"
        case .week:
            return count == 1 ? "week" : "weeks"
        case .day:
            return count == 1 ? "day" : "days"
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
}

//
//  DateType.swift
//  Day to Days
//
//  Created by mix on 10.09.2024.
//
import Foundation

enum DateType: String, CaseIterable, Codable {
    case day = "date_type_day"
    case week = "date_type_week"
    case month = "date_type_month"
    case year = "date_type_year"

    var label: String {
        switch self {
        case .year: return NSLocalizedString("date_label_years", comment: "")
        case .month: return NSLocalizedString("date_label_months", comment: "")
        case .week: return NSLocalizedString("date_label_weeks", comment: "")
        case .day: return NSLocalizedString("date_label_days", comment: "")
        }
    }

    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }

    static func fromData(_ data: Data) -> DateType? {
        return try? JSONDecoder().decode(DateType.self, from: data)
    }
}

//
//  DateType.swift
//  Day to Days
//
//  Created by mix on 10.09.2024.
//
import Foundation

enum DateType: CaseIterable, Codable {
    case day
    case week
    case month
    case year

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

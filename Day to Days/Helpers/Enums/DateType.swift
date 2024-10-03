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
        case .year: return "date_label_years".localized
        case .month: return "date_label_months".localized
        case .week: return "date_label_weeks".localized
        case .day: return "date_label_days".localized
        }
    }

    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }

    static func fromData(_ data: Data) -> DateType? {
        return try? JSONDecoder().decode(DateType.self, from: data)
    }
}

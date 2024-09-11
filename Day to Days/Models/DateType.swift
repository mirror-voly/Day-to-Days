//
//  DateType.swift
//  Day to Days
//
//  Created by mix on 10.09.2024.
//
import Foundation

enum DateType: String, CaseIterable, Codable {
    case day = "Days"
    case weak = "Days and Weaks"
    case month = "Days, Weaks, Months"
    case year = "All"

    var label: String {
        switch self {
        case .year: return "years"
        case .month: return "months"
        case .weak: return "weeks"
        case .day: return "days"
        }
    }

    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }

    static func fromData(_ data: Data) -> DateType? {
        return try? JSONDecoder().decode(DateType.self, from: data)
    }
}
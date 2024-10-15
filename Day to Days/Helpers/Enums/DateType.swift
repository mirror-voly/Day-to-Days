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

    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }

    static func fromData(_ data: Data) -> DateType? {
        return try? JSONDecoder().decode(DateType.self, from: data)
    }
}

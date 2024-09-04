//
//  DateCalculator.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import Foundation

final class DateCalculator {
    static func daysFrom(thisDate: Date) -> (days: String, description: String) {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: thisDate, to: currentDate)
        let daysCounter = components.day ?? 0
        let daysString = String(daysCounter).replacingOccurrences(of: "-", with: "")
        let description = daysCounter > 0 ? "gone" : "left"
        return (daysString, description)
    }
}

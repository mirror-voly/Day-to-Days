//
//  DateCalculator.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import Foundation

final class DateCalculator {
    func daysFrom(thisDate: Date) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: thisDate, to: currentDate)
        let daysString = String(components.day ?? 0)
        return daysString
    }
}

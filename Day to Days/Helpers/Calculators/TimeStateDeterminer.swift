//
//  TimeStateDeterminer.swift
//  Day to Days
//
//  Created by mix on 30.09.2024.
//

import Foundation

final class TimeStateDeterminer {
    func determineFutureOrPast(for date: Date) -> TimeStateType {
        let currentDate = Date()
        let calendar = Calendar.current
        if calendar.isDate(date, inSameDayAs: currentDate) {
            return .present
        } else {
            return date < currentDate ? .past : .future
        }
    }
}

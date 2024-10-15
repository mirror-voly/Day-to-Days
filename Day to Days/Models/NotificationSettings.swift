//
//  NotificationSettings.swift
//  Day to Days
//
//  Created by mix on 13.10.2024.
//

import Foundation

final class NotificationSettings: Codable {
    let dateType: DateType
    let date: Date
    let detailed: Bool
    
    init(dateType: DateType, date: Date, detailed: Bool) {
        self.dateType = dateType
        self.date = date
        self.detailed = detailed
    }
}

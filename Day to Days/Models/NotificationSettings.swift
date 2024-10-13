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
    
    init(dateType: DateType, date: Date) {
        self.dateType = dateType
        self.date = date
    }
}

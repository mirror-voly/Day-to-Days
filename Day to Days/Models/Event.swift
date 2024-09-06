//
//  Day.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct Event: Identifiable, Equatable {
    enum DateType: String, CaseIterable {
        case day = "Days"
        case weak = "Days and Weaks"
        case month = "Days, Weaks, Months"
        case year = "All"
    }
    var id: UUID = UUID()
    let title: String
    let description: String
    let date: Date
    let dateType: DateType
    let color: Color
}

extension Event {
    static var dummy: Event {
        .init(title: "My first try", description: "Do not know what to say", date: ISO8601DateFormatter().date(from: "2023-01-12T19:30:00Z")!, dateType: .day, color: .white)
    }
}

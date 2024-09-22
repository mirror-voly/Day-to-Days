//
//  EventWidget.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.
//

import Foundation

final class EventWidget: Codable {
    let name: String
    let id: UUID
    let date: Date
    var dateTypeData: Data?

    var dateType: DateType {
        guard let data = dateTypeData else { return .day}
        return DateType.fromData(data) ?? .day
    }

    init(name: String, id: UUID, date: Date, dateType: DateType) {
        self.name = name
        self.id = id
        self.date = date
        self.dateTypeData = dateType.toData()
    }
}

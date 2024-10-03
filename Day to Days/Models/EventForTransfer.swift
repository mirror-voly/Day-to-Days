//
//  EventForTransfer.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.
//

import Foundation

final class EventForTransfer: Codable {
    let title: String
    let id: UUID
    let date: Date
    let dateType: DateType
    let color: ColorType

    init(name: String, id: UUID, date: Date, dateType: DateType, color: ColorType) {
        self.title = name
        self.id = id
        self.date = date
        self.dateType = dateType
        self.color = color
    }
}

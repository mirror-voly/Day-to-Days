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

    init(name: String, id: UUID, date: Date) {
        self.name = name
        self.id = id
        self.date = date
    }
}

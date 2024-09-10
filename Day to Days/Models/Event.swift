//
//  Day.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct Event: Identifiable, Equatable, Hashable, Codable {

    var id: UUID = UUID()
    let title: String
    let info: String
    let date: Date
    let dateType: DateType
    var colorType: ColorType

    var color: Color {
        get {
            colorType.getColor
        }
        set {
            colorType = newValue.getColorType
        }
    }

    init(id: UUID = UUID(), title: String, info: String, date: Date, dateType: DateType, color: Color) {
        self.id = id
        self.title = title
        self.info = info
        self.date = date
        self.dateType = dateType
        self.colorType = color.getColorType
    }

    // Инициализатор без id
    init(title: String, info: String, date: Date, dateType: DateType, color: Color) {
        self.title = title
        self.info = info
        self.date = date
        self.dateType = dateType
        self.colorType = color.getColorType
    }
}

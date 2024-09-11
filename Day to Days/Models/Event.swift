//
//  Day.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI
import RealmSwift

class Event: Object, Identifiable {

    @Persisted var id: UUID = UUID()
    @Persisted var title: String = ""
    @Persisted var info: String = ""
    @Persisted var date: Date = Date()
    @Persisted var dateTypeData: Data?
    @Persisted var colorTypeData: Data?

    var dateType: DateType {
        get {
            if let data = dateTypeData {
                return DateType.fromData(data) ?? .day
            }
            return .day
        }
        set {
            dateTypeData = newValue.toData()
        }
    }

    var colorType: ColorType {
        get {
            if let data = colorTypeData {
                return ColorType.fromData(data) ?? .gray
            }
            return .gray
        }
        set {
            colorTypeData = newValue.toData()
        }
    }

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
        self.dateTypeData = dateType.toData()
        self.colorTypeData = color.getColorType.toData()
    }

    init(title: String, info: String, date: Date, dateType: DateType, color: Color) {
        self.title = title
        self.info = info
        self.date = date
        self.dateTypeData = dateType.toData()
        self.colorTypeData = color.getColorType.toData()
    }

    override class func primaryKey() -> String? {
        return "id"
    }

    override init() {
        super.init()
    }
}

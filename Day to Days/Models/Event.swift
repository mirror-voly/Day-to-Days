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
    @Persisted var title: String = Constants.emptyString
    @Persisted var info: String = Constants.emptyString
    @Persisted var date: Date = Date()
    @Persisted var dateTypeData: Data?
    @Persisted var colorTypeData: Data?
	@Persisted var imageData: Data?
	
    var dateType: DateType {
        get {
            guard let data = dateTypeData else { return .day }
            return DateType.fromData(data) ?? .day
        }
        set {
            dateTypeData = newValue.toData()
        }
    }

    var color: Color {
        get {
            guard let data = colorTypeData else { return .gray}
            let colorType = ColorType.fromData(data) ?? .gray
            return colorType.getColor
        }
        set {
            colorTypeData = newValue.getColorType.toData()
        }
    }

	init(id: UUID = UUID(), title: String, info: String, date: Date, dateType: DateType, color: Color, imageData: Data?) {
        self.id = id
        self.title = title
        self.info = info
        self.date = date
        self.dateTypeData = dateType.toData()
        self.colorTypeData = color.getColorType.toData()
		self.imageData = imageData
    }

    init(title: String, info: String, date: Date, dateType: DateType, color: Color, imageData: Data?) {
        self.title = title
        self.info = info
        self.date = date
        self.dateTypeData = dateType.toData()
        self.colorTypeData = color.getColorType.toData()
		self.imageData = imageData
    }

    override class func primaryKey() -> String? {
        return "id"
    }

    override init() {
        super.init()
    }
}

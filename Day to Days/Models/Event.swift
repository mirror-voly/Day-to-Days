//
//  Day.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct Event: Identifiable {
    enum DateType: String, CaseIterable {
        case day = "Days"
        case weak = "Days and Weaks"
        case month = "Days, Weaks, Months"
        case year = "All"
    }
    let id: UUID = UUID()
    var title: String
    var description: String
    var date: Date
    var dateType: DateType
    var color: Color
}

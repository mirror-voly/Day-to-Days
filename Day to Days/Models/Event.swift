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
    let id: UUID = UUID()
    let title: String
    let description: String
    let date: Date
    let dateType: DateType
    let color: Color
}

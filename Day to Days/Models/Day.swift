//
//  Day.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct Day: Identifiable {
    let id: UUID = UUID()
    var date: Date
    var title: String
    var color: Color
}

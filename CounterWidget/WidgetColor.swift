//
//  WidgetColor.swift
//  CounterWidgetExtension
//
//  Created by mix on 22.09.2024.
//

import SwiftUI
import WidgetKit
import AppIntents

struct WidgetColor: AppEntity {
    var id: String
    var color: Color

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Color"
    static var defaultQuery = WidgetColorQuery()
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }

    static var allColors: [WidgetColor] = [
        WidgetColor(id: "Brown", color: .brown),
        WidgetColor(id: "Red", color: .red),
        WidgetColor(id: "Blue", color: .blue),
        WidgetColor(id: "System default", color: .primary)
    ]
}

//
//  AppIntent.swift
//  CounterWidget
//
//  Created by mix on 20.09.2024.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Set color"
    static var description = IntentDescription("Edit number color.")

    @Parameter(title: "Color")
    var numberColor: WidgetColor
}

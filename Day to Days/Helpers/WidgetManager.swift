//
//  WidgetManager.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.
//

import UIKit
import WidgetKit

final class WidgetManager {

    static private func makeEventWidget(event: Event) -> EventWidget {
        return EventWidget(name: event.title, id: event.id, date: event.date, dateType: event.dateType)
    }

    static func sendToWidgetsThis(_ events: [Event]) {
        var eventsForWidget: [EventWidget] = []
        for event in events {
            eventsForWidget.append(makeEventWidget(event: event))
        }
        do {
            let data = try JSONEncoder().encode(eventsForWidget)
            if let userDefaults = UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget") {
                userDefaults.set(data, forKey: "counters")
                WidgetCenter.shared.reloadTimelines(ofKind: "CounterWidget")
            } else {
                print("UserDefaults could not be initialized.")
            }
        } catch {
            print("Saving error occurred: \(error.localizedDescription)")
        }
    }
}

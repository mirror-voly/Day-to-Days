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

    static func saveEventForWidget(_ event: Event) {
        let eventForWidget = makeEventWidget(event: event)
        do {
            let data = try JSONEncoder().encode(eventForWidget)
            if let userDefaults = UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget") {
                userDefaults.set(data, forKey: "counter")
                WidgetCenter.shared.reloadTimelines(ofKind: "CounterWidget")
            } else {
                print("UserDefaults could not be initialized.")
            }
        } catch {
            print("Editing error occurred: \(error.localizedDescription)")
        }
    }

}

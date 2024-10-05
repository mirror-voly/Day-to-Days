//
//  WidgetManager.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.
//

import UIKit
import WidgetKit

final class WidgetManager {

    static private func makeEventsForTransfer(event: Event) -> EventForTransfer {
        return EventForTransfer(name: event.title,
                           id: event.id,
                           date: event.date,
                           dateType: event.dateType,
                           color: event.color.getColorType)
    }

    static func sendToWidgetsThis(_ events: [Event]) {
        DispatchQueue.global(qos: .background).async {
            var eventsForWidget: [EventForTransfer] = []
            for event in events {
                eventsForWidget.append(makeEventsForTransfer(event: event))
            }
            do {
                let data = try JSONEncoder().encode(eventsForWidget)
                if let userDefaults = UserDefaults(suiteName: Constants.suiteName) {
                    userDefaults.set(data, forKey: Constants.widgetStorage)
                    WidgetCenter.shared.reloadTimelines(ofKind: Constants.widgetKind)
                } else {
                    print("UserDefaults could not be initialized.")
                }
            } catch {
                print("Saving error occurred: \(error.localizedDescription)")
            }
        }
    }
}

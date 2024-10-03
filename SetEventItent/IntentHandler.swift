//
//  IntentHandler.swift
//  SetEventItent
//
//  Created by mix on 02.10.2024.
//

import Intents
import SwiftUI

class IntentHandler: INExtension {
    @AppStorage("counters", store: UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget"))
    var data = Data()
}

extension IntentHandler: SetupEventIntentHandling {

    func getEvents() -> [EventWidget] {
        if let decodedEvent = try? JSONDecoder().decode([EventWidget].self, from: data) {
            return decodedEvent
        }
        return []
    }

    func provideWidgetEventOptionsCollection(for intent: SetupEventIntent,
                                             with completion: @escaping (INObjectCollection<WidgetEvent>?,
                                                                         (any Error)?) -> Void) {
            let events = self.getEvents()
            var widgetEvents: [WidgetEvent] = [WidgetEvent(identifier: "1", display: "1")]
            for event in events {
                widgetEvents.append(WidgetEvent(identifier: event.id.uuidString, display: event.name))
            }
            let collection: [WidgetEvent] = widgetEvents
            completion(INObjectCollection(items: collection), nil)
    }
}

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
    private var data = Data()

    private func decodeEvents() -> [EventForTransfer] {
        do {
            return try JSONDecoder().decode([EventForTransfer].self, from: data)
        } catch {
            return []
        }
    }
}

extension IntentHandler: SetupEventIntentHandling {
    func provideWidgetEventOptionsCollection(for intent: SetupEventIntent,
                                             with completion: @escaping (INObjectCollection<WidgetEvent>?,
                                                                         (any Error)?) -> Void) {
        let events = decodeEvents()
        let widgetEvents = events.map { event in
            WidgetEvent(identifier: event.id.uuidString, display: event.title)
        }
        let collection = INObjectCollection(items: widgetEvents)
        completion(collection, nil)
    }
}

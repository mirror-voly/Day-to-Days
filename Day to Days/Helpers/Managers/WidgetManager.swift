//
//  WidgetManager.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.
//

import UIKit
import WidgetKit

final class WidgetManager {

	private static func makeEventsForTransfer(event: Event) -> EventForTransfer {
        return EventForTransfer(name: event.title,
                           id: event.id,
                           date: event.date,
                           dateType: event.dateType,
                           color: event.color.getColorType)
    }

    static func sendEventsToOverTargets(_ events: [Event], completion: @escaping (Result<Void, Error>) -> Void) {
		DispatchQueue.global(qos: .utility).async {
            var eventsForWidget: [EventForTransfer] = []
            for event in events {
                eventsForWidget.append(makeEventsForTransfer(event: event))
            }
            do {
                let data = try JSONEncoder().encode(eventsForWidget)
                if let userDefaults = UserDefaults(suiteName: Constants.suiteName) {
                    userDefaults.set(data, forKey: Constants.widgetStorage)
                    completion(.success(()))
                    WidgetCenter.shared.reloadTimelines(ofKind: Constants.widgetKind)
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}

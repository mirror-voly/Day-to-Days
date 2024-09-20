//
//  WidgetManager.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.
//

import UIKit
import WidgetKit

final class WidgetManager {
    let encoder = JSONEncoder()
//    private var eventData = Date()
//    var event: Event?

    func updateAction(event: Event) {
        do {
            let data = try encoder.encode(event)
            UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget")?.set(Data.self, forKey: "counter")
            WidgetCenter.shared.reloadTimelines(ofKind: "CounterWidget")
        } catch {
            print("Editing error occurred: \(error.localizedDescription)")
        }
    }
}

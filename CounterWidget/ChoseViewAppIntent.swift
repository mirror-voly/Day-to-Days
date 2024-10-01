//
//  ChoseViewAppIntent.swift
//  Day to Days
//
//  Created by mix on 01.10.2024.
//

import WidgetKit
import AppIntents

struct SetChosenEventToWidget: AppIntent {
    static var title: LocalizedStringResource = "Chose"
    
    @Parameter(title: "eventID")
    var eventID: String

    func perform() async throws -> some IntentResult {
        .result()
    }
    
    init(counter: String) {
        self.eventID = eventID
    }
    
    init() {
        eventID = ""
    }
}

struct IncreaseCounter: AppIntent {
    static var title: LocalizedStringResource = "Up"
    
    func perform() async throws -> some IntentResult {
        if let store = UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget") {
            let count = store.integer(forKey: "count")
            store.setValue(count + 1, forKey: "count")
            return .result()
        }
        return .result()
    }
}

struct DecriseCounter: AppIntent {
    static var title: LocalizedStringResource = "Down"
    
    func perform() async throws -> some IntentResult {
        if let store = UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget") {
            let count = store.integer(forKey: "count")
            let changedCount = count - 1
            store.setValue(changedCount > -1 ? changedCount : 0, forKey: "count")
            return .result()
        }
        return .result()
    }
}

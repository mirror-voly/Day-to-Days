//
//  ChoseViewAppIntent.swift
//  Day to Days
//
//  Created by mix on 01.10.2024.
//
//
//import WidgetKit
//import AppIntents
//
//
//struct SetChosenEventToWidget: AppIntent {
//    static var title: LocalizedStringResource = "Chose"
//    
//    @Parameter(title: "widgetID")
//    var widgetID: String
//    
//    @Parameter(title: "eventID")
//    var eventID: String
//
//    func perform() async throws -> some IntentResult {
//        if let store = UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget") {
//            store.setValue(eventID, forKey: widgetID)
//            return .result()
//        }
//        return .result()
//    }
//    
//    init(widgetID: String, eventID: String) {
//        self.widgetID = widgetID
//        self.eventID = eventID
//    }
//    
//    init() {
//        
//    }
//}
//
//struct IncreaseCounter: AppIntent {
//    static var title: LocalizedStringResource = "Up"
//    
//    @Parameter(title: "eventsCount")
//    var eventsCount: Int
//    
//    func perform() async throws -> some IntentResult {
//        if let store = UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget") {
//            let count = store.integer(forKey: "widgetCount")
//            let changedCount = min(count + 1, eventsCount - 1)
//            store.setValue(changedCount, forKey: "widgetCount")
//            return .result()
//        }
//        return .result()
//    }
//    
//    init(eventsCount: Int) {
//        self.eventsCount = eventsCount
//    }
//    
//    init() {}
//}
//
//struct DecriseCounter: AppIntent {
//    static var title: LocalizedStringResource = "Down"
//    
//    func perform() async throws -> some IntentResult {
//        if let store = UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget") {
//            let count = store.integer(forKey: "widgetCount")
//            let changedCount = count - 1
//            store.setValue(changedCount > -1 ? changedCount : 0, forKey: "widgetCount")
//            return .result()
//        }
//        return .result()
//    }
//}

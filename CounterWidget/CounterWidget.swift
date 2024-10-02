//
//  CounterWidget.swift
//  CounterWidget
//
//  Created by mix on 20.09.2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    @AppStorage("counters", store: UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget"))
    var data = Data()

    func getEvents() -> [EventWidget] {
        let events: [EventWidget]
        if let decodedEvent = try? JSONDecoder().decode([EventWidget].self, from: data) {
            events = decodedEvent
        } else {
            events = [EventWidget(name: "title".localized.capitalized, id: UUID(), date: Date(), dateType: .day)]
        }
        return events
    }
    
    func getCount() -> Int {
        let store = UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget")
        return store?.integer(forKey: "widgetCount") ?? 0
    }
    
    func getEventID(widgetID: String) -> String? {
        let store = UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget")
        return store?.string(forKey: widgetID)
    }

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), events: [EventWidget(name: "title".localized.capitalized, id: UUID(), date: Date(), dateType: .day)], widgetColor: .allColors[0], count: 0, widgetID: UUID().uuidString, eventID: "")
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        let event = getEvents()
        let widgetID = UUID().uuidString
        return SimpleEntry(date: Date(), configuration: configuration, events: event, widgetColor: configuration.numberColor, count: getCount(), widgetID: widgetID, eventID: getEventID(widgetID: widgetID))
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        let widgetID = UUID().uuidString
        if let events = try? JSONDecoder().decode([EventWidget].self, from: data) {
            let currentDate = Date()
            for hourOffset in 0 ..< 5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration, events: events, widgetColor: configuration.numberColor, count: getCount(), widgetID: widgetID, eventID: getEventID(widgetID: widgetID))
                entries.append(entry)
            }
        }
        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let events: [EventWidget]
    let widgetColor: WidgetColor
    let count: Int
    let widgetID: String
    let eventID: String?
}

struct CounterWidgetEntryView : View {
    var entry: Provider.Entry
    var body: some View {
//        if entry.eventID == nil {
            Text(String(entry.events.count))
        Text(entry.widgetID)
            Button(intent: SetChosenEventToWidget(widgetID: entry.widgetID, eventID: entry.events[entry.count].id.uuidString)) {
                Text(entry.events[entry.count].name)
                Text(String(entry.count))
            }
            HStack {
                Button(intent: DecriseCounter()) {
                    Text("Down")
                }
                Button(intent: IncreaseCounter(eventsCount: entry.events.count)) {
                    Text("Up")
                }
            }
//        } else if entry.eventID ==  {
//            Text(entry.eventID ?? "")
//        }
//        VStack {
//            WidgetView(event: entry.event, numberColor: entry.configuration.numberColor.color)
//        }
//        .containerBackground(.brown, for: .widget)
    }
}

struct CounterWidget: Widget {
    let kind: String = "CounterWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            CounterWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemSmall])
    }
}

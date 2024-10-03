//
//  CounterWidget.swift
//  CounterWidget
//
//  Created by mix on 20.09.2024.
//

import WidgetKit
import SwiftUI

struct Provider: IntentTimelineProvider {
    @AppStorage("counters", store: UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget"))
    private var data = Data()
    
    private func decodeEvents(from data: Data) -> [EventWidget] {
        do {
            return try JSONDecoder().decode([EventWidget].self, from: data)
        } catch {
            return []
        }
    }

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: SetupEventIntent(), events: [EventWidget()])
    }

    func getSnapshot(for configuration: SetupEventIntent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(SimpleEntry(date: Date(), configuration: configuration, events: decodeEvents(from: data)))
    }

    func getTimeline(for configuration: SetupEventIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []
        if let events = try? JSONDecoder().decode([EventWidget].self, from: data) {
            let currentDate = Date()
            for hourOffset in 0 ..< 5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration, events: events)
                entries.append(entry)
            }
        }
        completion(Timeline(entries: entries, policy: .atEnd))
    }

    typealias Entry = SimpleEntry
    typealias Intent = SetupEventIntent
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: SetupEventIntent
    let events: [EventWidget]
}

struct CounterWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        WidgetView(events: entry.events, eventID: entry.configuration.WidgetEvent?.identifier ?? "" )
    }
}

struct CounterWidget: Widget {
    let kind: String = "CounterWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SetupEventIntent.self, provider: Provider()) { entry in
            CounterWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemSmall])
    }
}

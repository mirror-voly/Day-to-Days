//
//  CounterWidget.swift
//  CounterWidget
//
//  Created by mix on 20.09.2024.
//

import WidgetKit
import SwiftUI

struct Provider: IntentTimelineProvider {
    //    @AppStorage("counters", store: UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget"))
    //    var data = Data()
    //
    //    func getEvents() -> [EventWidget] {
    //        let events: [EventWidget]
    //        if let decodedEvent = try? JSONDecoder().decode([EventWidget].self, from: data) {
    //            events = decodedEvent
    //        } else {
    //            events = [EventWidget(name: "title".localized.capitalized, id: UUID(), date: Date(), dateType: .day)]
    //        }
    //        return events
    //    }

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: SetupEventIntent())
    }

    func getSnapshot(for configuration: SetupEventIntent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(SimpleEntry(date: Date(), configuration: configuration))
    }

    func getTimeline(for configuration: SetupEventIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []
        if let events = try? JSONDecoder().decode([EventWidget].self, from: Data()) {
            let currentDate = Date()
            for hourOffset in 0 ..< 5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration)
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
}

struct CounterWidgetEntryView : View {
    var entry: Provider.Entry
    var body: some View {
        Text("entry.widgetID")
    }
}

struct CounterWidget: Widget {
    let kind: String = "CounterWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SetupEventIntent.self, provider: Provider()) { entry in
            CounterWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

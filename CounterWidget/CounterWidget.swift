//
//  CounterWidget.swift
//  CounterWidget
//
//  Created by mix on 20.09.2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    @AppStorage("counter", store: UserDefaults(suiteName: "group.onlyMe.Day-to-Days.CounterWidget"))
    var data = Data()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), event: EventWidget(name: "Title", id: UUID(), date: Date()))
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        if let event = try? JSONDecoder().decode(EventWidget.self, from: data) {
            return SimpleEntry(date: Date(), configuration: configuration, event: event)
        } else {
            return SimpleEntry(date: Date(), configuration: configuration, event: EventWidget(name: "error", id: UUID(), date: Date()))
        }
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        if let event = try? JSONDecoder().decode(EventWidget.self, from: data) {
            let currentDate = Date()
            for hourOffset in 0 ..< 5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration, event: event)
                entries.append(entry)
            }
        }
        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let event: EventWidget
}

struct CounterWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            WidgetView(event: entry.event)
        }
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

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    CounterWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, event: EventWidget(name: "", id: UUID(), date: Date()))
    SimpleEntry(date: .now, configuration: .starEyes, event: EventWidget(name: "", id: UUID(), date: Date()))
}

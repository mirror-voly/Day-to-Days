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
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), event: EventWidget(name: "title".localized.capitalized, id: UUID(), date: Date(), dateType: .day), widgetColor: .allColors[0])
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        let event: EventWidget
        if let decodedEvent = try? JSONDecoder().decode(EventWidget.self, from: data) {
            event = decodedEvent
        } else {
            event = EventWidget(name: "title".localized.capitalized, id: UUID(), date: Date(), dateType: .day)
        }
        return SimpleEntry(date: Date(), configuration: configuration, event: event, widgetColor: configuration.numberColor)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        if let event = try? JSONDecoder().decode(EventWidget.self, from: data) {
            let currentDate = Date()
            for hourOffset in 0 ..< 5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, configuration: configuration, event: event, widgetColor: configuration.numberColor)
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
    let widgetColor: WidgetColor?
}

struct CounterWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            WidgetView(numberColor: entry.configuration.numberColor.color, event: entry.event)
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.brown.opacity(0.1))
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

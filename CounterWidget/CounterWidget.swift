//
//  CounterWidget.swift
//  CounterWidget
//
//  Created by mix on 20.09.2024.
//

import WidgetKit
import SwiftUI

struct Provider: IntentTimelineProvider {
    @AppStorage(Constants.widgetStorage,
                store: UserDefaults(suiteName: Constants.suiteName))
    private var data = Data()
    
    private func decodeEvents() -> [EventForTransfer] {
        do {
            return try JSONDecoder().decode([EventForTransfer].self, from: data)
        } catch {
            return []
        }
    }

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: SetupEventIntent(),
                    events: [EventForTransfer(name: Constants.emptyString, id: UUID(), date: Date(), dateType: .day, color: .brown)])
    }

    func getSnapshot(for configuration: SetupEventIntent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(SimpleEntry(date: Date(), configuration: configuration, events: decodeEvents()))
    }

    func getTimeline(for configuration: SetupEventIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []
        let events = decodeEvents()
        let currentDate = Date()
        for hourOffset in .zero ..< Constants.widgetHourOffset {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, events: events)
            entries.append(entry)
        }
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: SetupEventIntent
    let events: [EventForTransfer]
}

struct CounterWidgetEntryView : View {
    let entry: Provider.Entry
    let viewModel: WidgetViewModel
    
    var body: some View {
        if viewModel.inList {
            MainWidgetView(viewModel: viewModel)
        } else {
            EmptyWidgetView()
        }
    }
}

struct CounterWidget: Widget {

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: Constants.widgetKind,
                            intent: SetupEventIntent.self,
                            provider: Provider()) { entry in
            CounterWidgetEntryView(entry: entry,
                                   viewModel: WidgetViewModel(events: entry.events,
                                                              eventID: entry.configuration.WidgetEvent?.identifier ?? Constants.emptyString))
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemSmall])
    }
}

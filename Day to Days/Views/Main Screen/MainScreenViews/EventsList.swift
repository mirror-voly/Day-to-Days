//
//  EventsList.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//
import RealmSwift
import SwiftUI

struct EventsList: View {
    @Environment(DataStore.self) private var dataStore
    @ObservedResults(Event.self) var allEvents
    var body: some View {
        VStack {
            List {
                ForEach(allEvents) { event in
                    NavigationLink(value: event) {
                        Divider()
                        EventsItemView(event: event)
                    }
                }
                .onDelete { index in
                    dataStore.deleteEventAt(index)
                }
            }
            .listStyle(.plain)
        }
        .navigationDestination(for: Event.self) { event in
            EventInfoScreen(event: event)
        }
    }
}

#Preview {
    EventsList()
}

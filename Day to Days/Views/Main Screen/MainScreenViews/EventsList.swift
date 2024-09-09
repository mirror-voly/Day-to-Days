//
//  EventsList.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct EventsList: View {
    @Environment(DataStore.self) private var dataStore
    var body: some View {
        List {
            ForEach(dataStore.allEvents) { event in
                NavigationLink(value: event) {
                    Divider()
                    EventsItemView(day: event)
                }
                .navigationDestination(for: Event.self) { event in
                    EventInfoScreen(event: event)
                }
            }
            .onDelete { index in
                dataStore.deleteEventAt(index)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    EventsList()
}

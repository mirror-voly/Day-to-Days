//
//  EventsList.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//
import RealmSwift
import SwiftUI

struct EventsList: View {
    @ObservedResults(Event.self) var allEvents
    var body: some View {
        VStack {
            List {
                // TODO: make mass delete
                // TODO: make sort ability
                ForEach(allEvents) { event in
                    NavigationLink(value: event) {
                        Divider()
                        EventsItemView(event: event)
                    }
                }
                .onDelete(perform: $allEvents.remove)
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

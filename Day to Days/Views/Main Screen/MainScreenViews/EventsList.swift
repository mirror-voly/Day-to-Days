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
                        .navigationTitle(event.title)
                        .toolbarBackground(event.color.opacity(0.8), for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .navigationBarBackButtonHidden()
                }
            }.onDelete { index in
                dataStore.deleteEventAt(index)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    EventsList()
}

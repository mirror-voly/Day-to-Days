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
    @State private var editMode: EditMode = .inactive
    @State private var navigationLinkIsPresented = false
    @State private var ascending = true
    @State private var sortBy: SortType = .non
    @State private var selectedEvent: Event?
    @State private var selectedState: [UUID: Bool] = [:]
    @ObservedResults(Event.self) var allEvents

    var sortedEvents: [Event] {
        SortRelults.sortResulsBy(allEvents: allEvents, sortBy: sortBy, ascending: ascending)
    }

    // MARK: - View
    var body: some View {
        VStack {
            List {
                // TODO: make sort ability
                ForEach(sortedEvents) { event in
                    EventsItemView(editMode: $editMode, isSelected: Binding(
                        get: { selectedState[event.id] ?? false },
                        set: { selectedState[event.id] = $0 }
                    ), event: event)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if editMode == .inactive {
                            selectedEvent = event
                            navigationLinkIsPresented = true
                        } else {
                            selectedState[event.id, default: false].toggle()
                        }
                    }
                    .swipeActions {
                        if editMode == .inactive {
                            Button(role: .destructive) {
                                $allEvents.remove(event)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            Button(role: .cancel) {
                                editMode = .active
                            } label: {
                                Label("Multiple \n selection", systemImage: "checkmark.circle")
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationDestination(isPresented: $navigationLinkIsPresented) {
                if let event = selectedEvent {
                    EventInfoScreen(event: event)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    sortBy = .date
                    ascending.toggle()
                } label: {
                    Text("Sort")
                }
                .buttonStyle(BorderedButtonStyle())
                .tint(.primary)
            }
            if editMode == .active {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        editMode = .inactive
                        if !dataStore.noSelectedEvents {
                            dataStore.removeSelectedEvents()
                        }
                    } label: {
                        Text(dataStore.noSelectedEvents ? "Done" : "Delete selected")
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .tint(.primary)
                }

                if !dataStore.noSelectedEvents {
                ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dataStore.makeSelectedEventsEmpty()
                            editMode = .inactive
                        } label: {
                            Text("Cancel")
                        }
                        .buttonStyle(BorderedButtonStyle())
                        .tint(.primary)
                    }
                }
            }
        }

    }
}

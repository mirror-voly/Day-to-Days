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
    @Environment(DataStore.self) private var dataStore
    @State private var navigationLinkIsPresented = false
    @State private var editMode: EditMode = .inactive
    @State private var selectedEvent: Event?
    var body: some View {
        VStack {
            List {
                // TODO: make mass delete
                // TODO: make sort ability
                ForEach(allEvents) { event in
                    ZStack(alignment: .center) {
                        EventsItemView(editMode: $editMode, event: event)
                            .onTapGesture {
                                if editMode == .inactive {
                                    selectedEvent = event
                                }
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    $allEvents.remove(event)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                Button(role: .cancel) {
                                    editMode = .active
                                } label: {
                                    Label("Selection", systemImage: "checkmark.circle")
                                }
                            }
                            .containerShape(Rectangle())
                    }
                    
                }
            }
            .listStyle(.plain)
            .onChange(of: selectedEvent, { _, _ in
                if selectedEvent != nil {
                    navigationLinkIsPresented = true
                }
            })
            .navigationDestination(isPresented: $navigationLinkIsPresented) {
                if selectedEvent != nil {
                    EventInfoScreen(event: selectedEvent!)
                }

            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                if editMode == .active {
                    if dataStore.noSelectedEvents {
                        Button {
                            editMode = .inactive
                        } label: {
                            Text("Done")
                        }
                    } else {
                        Button {
                            editMode = .inactive
                            dataStore.removeSelectedEvents()
                        } label: {
                            Text("Delete selected")
                        }
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                if editMode == .active {
                    if !dataStore.noSelectedEvents {
                        Button {
                            dataStore.makeSelectedEventsEmpty()
                            editMode = .inactive
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
            }
        }

    }
}

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
    @State private var sortBy: SortType = .none
    @State private var selectedEvent: Event?
    @State private var selectedState: [UUID: Bool] = [:]
    @ObservedResults(Event.self) var allEvents

    var sortedEvents: [Event] {
        SortRelults.sortResulsBy(allEvents: allEvents, sortBy: sortBy, ascending: ascending).reversed()
    }
    // MARK: - Toolbar Items
    // TODO: Need helpers
    private var sortMenu: some ToolbarContent {
            ToolbarItem(placement: .topBarLeading) {
                Menu {
                    ForEach(SortType.allCases, id: \.self) { type in
                        Button(role: .cancel) {
                            sortBy = type
                            if type != .none {
                                ascending.toggle()
                            }
                        } label: {
                            let imageName = ascending ? "arrow.up.circle" : "arrow.down.circle"
                            HStack {
                                Text(type.rawValue)
                                Image(systemName: type != .none ? imageName : "dot.circle")
                            }
                        }
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down.circle")
                        .foregroundStyle(.gray)
                }
            }
    }
    // TODO: Need add localization on new strings
    private var editModeToolbar: some ToolbarContent {
        Group {
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

    // MARK: Swipe Actions
    private func deleteButton(for event: Event) -> some View {
        Button(role: .destructive) {
            $allEvents.remove(event)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }

    private func multipleSelectionButton() -> some View {
        Button(role: .cancel) {
            editMode = .active
        } label: {
            Label("Multiple \n selection", systemImage: "checkmark.circle")
        }
    }
    // MARK: TapGesture Actions
    private func onTapGestureSwitch(event: Event) {
        if editMode == .inactive {
            selectedEvent = event
            navigationLinkIsPresented = true
        } else {
            selectedState[event.id, default: false].toggle()
        }
    }

    // MARK: - View
    var body: some View {
        VStack {
            List {
                ForEach(sortedEvents) { event in
                    EventsItemView(editMode: $editMode, isSelected: Binding(
                        get: { selectedState[event.id] ?? false },
                        set: { selectedState[event.id] = $0 }
                    ), event: event)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onTapGestureSwitch(event: event)
                    }
                    .swipeActions {
                        if editMode == .inactive {
                            deleteButton(for: event)
                            multipleSelectionButton()
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .toolbar {
            if dataStore.noSelectedEvents {
                sortMenu
            }
            if editMode == .active {
                editModeToolbar
            }
        }
        .navigationDestination(isPresented: $navigationLinkIsPresented) {
            if let event = selectedEvent {
                EventInfoScreen(event: event)
            }
        }
    }
}

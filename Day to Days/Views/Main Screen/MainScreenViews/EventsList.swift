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

    // MARK: - View
    var body: some View {
        VStack {
            List {
                ForEach(dataStore.sortedEvents) { event in
                    EventsItemView(isSelected: Binding(
                        get: { dataStore.selectedState[event.id] ?? false },
                        set: { dataStore.selectedState[event.id] = $0 }
                    ), event: event)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        dataStore.onTapGestureSwitch(event: event)
                    }
                    .swipeActions {
                        if dataStore.editMode == .inactive {
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
            if dataStore.editMode == .active {
                editModeToolbar
            }
        }
        .navigationDestination(isPresented: Binding(
            get: { dataStore.navigationLinkIsPresented },
            set: { dataStore.navigationLinkIsPresented = $0 }
        )) {
            if let event = dataStore.selectedEvent {
                EventInfoScreen(event: event)
            }
        }
        .onAppear(perform: {
            dataStore.events = allEvents
        })
        .onChange(of: allEvents.count) { oldValue, newValue in
            DispatchQueue.main.async {
                dataStore.events = allEvents
            }
        }
    }
}

// MARK: - Toolbar Items
extension EventsList {
    private var sortMenu: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                ForEach(SortType.allCases, id: \.self) { type in
                    Button(role: .cancel) {
                        dataStore.sortBy = type
                        if type != .none {
                            dataStore.ascending.toggle()
                        }
                    } label: {
                        let imageName = dataStore.ascending ? "arrow.up.circle" : "arrow.down.circle"
                        HStack {
                            Text(type.rawValue.localized)
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

    private var editModeToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dataStore.editMode = .inactive
                    if !dataStore.noSelectedEvents {
                        dataStore.removeSelectedEvents()
                    }
                } label: {
                    Text(dataStore.noSelectedEvents ? "done".localized : "delete_selected".localized)
                }
                .buttonStyle(BorderedButtonStyle())
                .tint(.primary.opacity(dataStore.primaryOpacity))
            }

            if !dataStore.noSelectedEvents {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dataStore.makeSelectedEventsEmpty()
                        dataStore.editMode = .inactive
                    } label: {
                        Text("cancel".localized)
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .tint(.primary.opacity(dataStore.primaryOpacity))
                }
            }
        }
    }

    // MARK: Swipe Actions
    private func deleteButton(for event: Event) -> some View {
        Button(role: .destructive) {
            $allEvents.remove(event)
        } label: {
            Label("delete".localized, systemImage: "trash")
        }
    }

    private func multipleSelectionButton() -> some View {
        Button(role: .cancel) {
            dataStore.editMode = .active
        } label: {
            Label("multiple_selection".localized, systemImage: "checkmark.circle")
        }
    }
}

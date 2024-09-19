//
//  EventsList.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//
import RealmSwift
import SwiftUI

struct EventsList: View {
    @Environment(MainScreenViewModel.self) var viewModel
    @ObservedResults(Event.self) var allEvents

    // MARK: - View
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.sortedEvents, id: \.self) { event in
                    EventsItemView(event: event)
                    .background(
                        Group {
                            if viewModel.editMode == .inactive {
                                ZStack {
                                    Button("") {} // Bugfix to NavigationLink element if it selected after coming back
                                    NavigationLink("", value: event).opacity(0)
                                }
                            }
                        })
                    .swipeActions {
                        if viewModel.editMode == .inactive {
                            deleteButton(for: event)
                            multipleSelectionButton()
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .toolbar {
            if viewModel.noSelectedEvents {
                sortMenu
            }
            if viewModel.editMode == .active {
                editModeToolbar
            }
        }
        .navigationDestination(for: Event.self) { event in
            EventInfoScreen(event: event)
        }
        .onAppear(perform: {
            viewModel.setEvents(allEvents: allEvents)
        })
        .onChange(of: allEvents.count) { _, _ in
            viewModel.setEvents(allEvents: allEvents)
        }
    }
}

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

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.sortedEvents.indices, id: \.self) { index in
                    EventsItemView(index: index)
                    .background(
                        Group {
                            if !viewModel.editIsActivated {
                                ZStack {
                                    Button("") {} // Bugfix to NavigationLink element if it selected after coming back
                                    NavigationLink("", value: viewModel.sortedEvents[index]).opacity(0)
                                }
                            }
                        })
                    .swipeActions {
                        if !viewModel.editIsActivated {
                            deleteButton(for: index)
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
            if viewModel.editIsActivated {
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

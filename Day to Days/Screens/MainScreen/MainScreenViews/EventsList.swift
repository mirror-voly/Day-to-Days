//
//  EventsList.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//
import RealmSwift
import SwiftUI

struct EventsList: View {
    @Environment(MainScreenViewModel.self) private var viewModel
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

// MARK: - Toolbar Items
extension EventsList {
    private var sortMenu: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                ForEach(SortType.allCases, id: \.self) { type in
                    Button(role: .cancel) {
                        viewModel.sortButtonAction(type: type)
                    } label: {
                        HStack {
                            Text(type.rawValue.localized)
                            Image(systemName: type != .none ? viewModel.imageName : "dot.circle")
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
                    viewModel.setEditMode(mode: .inactive)
                    viewModel.removeSelectedEvents()
                } label: {
                    Text(viewModel.noSelectedEvents ? "done".localized : "delete_selected".localized)
                }
                .buttonStyle(BorderedButtonStyle())
                .tint(.primary.opacity(Сonstraints.primaryOpacity))
            }

            if !viewModel.noSelectedEvents {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.makeSelectedEventsEmpty()
                        viewModel.setEditMode(mode: .inactive)
                    } label: {
                        Text("cancel".localized)
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .tint(.primary.opacity(Сonstraints.primaryOpacity))
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
            viewModel.setEditMode(mode: .active)
        } label: {
            Label("multiple_selection".localized, systemImage: "checkmark.circle")
        }
    }
}

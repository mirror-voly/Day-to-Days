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

    private func isOutOfBounds(proxy: GeometryProxy) -> Bool {
        let frame = proxy.frame(in: .global)
        let screenHeight = UIScreen.main.bounds.height
        let limit = Constraints.frameBoundsLimit
        return frame.maxY < limit || frame.minY + limit > screenHeight || frame.minY < limit
    }

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.sortedEvents.indices, id: \.self) { index in
                    GeometryReader { proxy in
                        EventsItemView(index: index)
                            .blur(radius: isOutOfBounds(proxy: proxy) ? Constraints.originalSize: .zero)
                            .opacity(isOutOfBounds(proxy: proxy) ?
                                     Constraints.listItemAnimationScale: Constraints.originalSize)
                            .scaleEffect(isOutOfBounds(proxy: proxy) ?
                                         Constraints.listItemAnimationScale: Constraints.originalSize)
                            .background(
                                Group {
                                    if !viewModel.editIsActivated {
                                        ZStack {
                                            // Bugfix to NavigationLink element if it selected after coming back
                                            Button(Constants.emptyString) {}
                                            NavigationLink(Constants.emptyString,
                                                           value: viewModel.sortedEvents[index]).opacity(.zero)
                                        }
                                    }
                                })
                            .swipeActions {
                                if !viewModel.editIsActivated {
                                    deleteButton(for: index)
                                    multipleSelectionButton()
                                }
                            }
                            .animation(.linear, value: proxy.frame(in: .global).minY)
                    }
                    .frame(height: 115)
                }
                .listRowSeparator(.visible)
            }
            .listStyle(.plain)
        }
        .toolbar {
            if viewModel.noSelectedEvents && !viewModel.eventsIsEmpty {
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

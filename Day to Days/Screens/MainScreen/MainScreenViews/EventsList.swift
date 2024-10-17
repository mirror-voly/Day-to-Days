//
//  EventsList.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//
import RealmSwift
import SwiftUI

struct EventsList: View {
    @Environment(AlertManager.self) var alertManager
    @Environment(MainScreenViewModel.self) var viewModel
    @ObservedResults(Event.self) private var allEvents
	let notificationManager: NotificationManager
	var body: some View {
		VStack {
			List {
				ForEach(viewModel.sortedEvents, id: \.self) { event in
					EventsItemView(event: event, mainScreenViewModel: viewModel)
						.background(
							Group {
								if !viewModel.editIsActivated {
									ZStack {
										// Bugfix to NavigationLink element if it selected after coming back
										Button(Constants.emptyString) {}
										NavigationLink(Constants.emptyString , value: event).opacity(.zero)
									}
								}
							})
						.swipeActions {
							if !viewModel.editIsActivated {
								deleteButton(event.id)
								multipleSelectionButton()
							}
						}
				}
				.listRowSeparator(.visible)
			}
			.listStyle(.plain)
		}
		// MARK: - Toolbar elements
		.toolbar {
			if viewModel.noSelectedEvents && !viewModel.eventsIsEmpty {
				sortMenu
			}
			if viewModel.editIsActivated {
				editModeToolbar
			}
		}
		// MARK: - NavigationStack path opener
		.navigationDestination(for: Event.self) { event in
			EventInfoScreen(event: event, notificationManager: notificationManager)
		}
		.onOpenURL(perform: { url in
			EventSearch.findEventByURL(url: url,
										 events: viewModel.sortedEvents,
										 completion: { event in
				viewModel.path.append(event)
			})
		})
		// MARK: - Update
		.onAppear(perform: { viewModel.setEvents(allEvents: allEvents) })
		.onChange(of: allEvents.count) { _, _ in
			viewModel.setEvents(allEvents: allEvents)
			WidgetManager.sendToOtherTargetsThis(Array(allEvents), completion: { result in
				alertManager.getIdentifiebleErrorFrom(result: result)
			})
		}
	}
	init(notificationManager: NotificationManager) {
		self.notificationManager = notificationManager
	}
}

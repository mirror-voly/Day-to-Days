//
//  ContentView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//
import SwiftUI

struct MainScreen: View {
	@State var viewModel: MainScreenViewModel
	let notifiation: NotificationDelegate
	let notificationManager: NotificationManager
    // MARK: - View
    var body: some View {
		NavigationStack(path: $viewModel.path) {
			VStack(alignment: .center) {
				EventsList(notificationManager: notificationManager)
					.overlay {
						if viewModel.eventsIsEmpty {
							EventsListIsEmptyView(onAddNew: {
								viewModel.sheetIsOpened = true
							})
						}
					}
			}
			.navigationTitle("events".localized)
			// MARK: Sheet
			.sheet(isPresented: $viewModel.sheetIsOpened) {
				AddOrEditEventSheet(
					isOpened: $viewModel.sheetIsOpened,
					screenMode: .add,
					notificationManager: notificationManager)
				.interactiveDismissDisabled()
			}
			// MARK: Toolbar
			.toolbar {
				if viewModel.noSelectedEvents && !viewModel.eventsIsEmpty {
					addNewButton
				}
			}
			.fullScreenCover(isPresented: $viewModel.settingsFullScreenCover, content: {
				SettingsScreen()
			})
			.environment(viewModel)
			
		}
		.opacity(0.9)
		.background(
			BackgroundView(isPresented: viewModel.eventsIsEmpty)
		)
    }

	init() {
		self.notificationManager = NotificationManager()
		let viewModel = MainScreenViewModel(notificationManager: notificationManager)
		self.viewModel = viewModel
		self.notifiation = NotificationDelegate()
		notifiation.setViewModel(viewModel)
	}
}

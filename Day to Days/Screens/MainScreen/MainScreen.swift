//
//  ContentView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//
import RealmSwift
import SwiftUI

struct MainScreen: View {
    @Environment(AddOrEditEventSheetViewModel.self) var sheetViewModel
    @Environment(AlertManager.self) var alertManager
    @Bindable var viewModel: MainScreenViewModel
    // MARK: - View
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                EventsList()
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
                    viewModel: sheetViewModel
                )
                .interactiveDismissDisabled()
            }
            // MARK: Toolbar
            .toolbar {
                if viewModel.noSelectedEvents && !viewModel.eventsIsEmpty {
                    addNewButton
                }
            }
        }
        .environment(viewModel)
    }
}

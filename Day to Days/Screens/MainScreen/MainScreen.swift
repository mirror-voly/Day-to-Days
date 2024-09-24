//
//  ContentView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//
import RealmSwift
import SwiftUI

struct MainScreen: View {
    @Environment(AddOrEditEventSheetViewModel.self) private var sheetViewModel
    @Bindable var viewModel: MainScreenViewModel
    // MARK: - View
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                EventsList()
                    .overlay {
                        if viewModel.eventsIsEmpty {
                            EventsListIsEmpyView {
                                viewModel.sheetIsOpened = true
                            }
                        }
                    }
            }
            .navigationTitle("events".localized)
            .sheet(isPresented: $viewModel.sheetIsOpened) {
                        AddOrEditEventSheet(
                            isOpened: $viewModel.sheetIsOpened,
                            showAlert: $viewModel.alertIsPresented
                        )
                    }
            // MARK: Toolbar
            .toolbar {
                if viewModel.noSelectedEvents {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            sheetViewModel.setScreenMode(mode: .add)
                            viewModel.sheetIsOpened = true
                        } label: {
                            Image(systemName: "plus.circle")
                                .foregroundStyle(.gray)
                        }
                        .contextMenu {
                            HelpContextMenu(helpText: "new_event")
                        }
                    }
                }
            }
            // MARK: Alert
            .alert(isPresented: $viewModel.alertIsPresented, content: {
                NewAlert.showAlert {
                    sheetViewModel.makeCurrentEventNil()
                } onCancel: {
                    viewModel.sheetIsOpened = true
                }
            })
        }
    }
}

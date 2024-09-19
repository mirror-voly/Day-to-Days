//
//  ContentView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//
import RealmSwift
import SwiftUI

struct MainScreen: View {
    @Environment(MainScreenViewModel.self) private var viewModel
    @Environment(AddOrEditEventSheetViewModel.self) private var sheetViewModel
    @ObservedResults(Event.self) var allEvents

    // MARK: - View
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                EventsList()
                    .overlay {
                        if viewModel.sortedEvents.isEmpty {
                            EventsListIsEmpyView {
                                viewModel.sheetIsOpened = true
                            }
                        }
                    }
            }
            .navigationTitle("events".localized)
            .sheet(isPresented: Binding(get: {
                viewModel.sheetIsOpened
            }, set: { value in
                viewModel.sheetIsOpened = value
            }), content: {
                AddOrEditEventSheet(isOpened: Binding(get: {
                    viewModel.sheetIsOpened
                }, set: { value in
                    viewModel.sheetIsOpened = value
                }), showAlert: Binding(get: {
                    viewModel.alertIsPresented
                }, set: { value in
                    viewModel.alertIsPresented = value
                }))
            })
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
            .alert(isPresented: Binding(get: {
                viewModel.alertIsPresented
            }, set: { value in
                viewModel.alertIsPresented = value
            }), content: {
                NewAlert.showAlert {
                    sheetViewModel.makeCurrentEventNil()
                } onCancel: {
                    viewModel.sheetIsOpened = true
                }
            })
        }
    }
}

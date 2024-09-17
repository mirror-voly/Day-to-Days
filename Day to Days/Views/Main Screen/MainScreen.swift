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
    @State private var sheetIsOpened = false
    @State private var alertIsPresented = false

    // MARK: - View
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                EventsList()
                    .overlay {
                        if viewModel.sortedEvents.isEmpty {
                            EventsListIsEmpyView {
                                sheetIsOpened = true
                            }
                        }
                    }
            }
            .navigationTitle("events".localized)
            .sheet(isPresented: $sheetIsOpened, content: {
                AddOrEditEventSheet(isOpened: $sheetIsOpened,
                                    showAlert: $alertIsPresented)
            })
            // MARK: Toolbar
            .toolbar {
                if viewModel.noSelectedEvents {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            sheetIsOpened = true
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
            .alert(isPresented: $alertIsPresented, content: {
                NewAlert.showAlert {
                    sheetViewModel.makeCurrentEventNil()
                } onCancel: {
                    sheetIsOpened = true
                }
            })
        }
    }
}

#Preview {
    MainScreen()
}

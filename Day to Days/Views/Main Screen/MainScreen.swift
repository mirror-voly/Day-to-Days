//
//  ContentView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//
import RealmSwift
import SwiftUI

struct MainScreen: View {
    @Environment(DataStore.self) private var dataStore
    @ObservedResults(Event.self) var allEvents
    @State private var sheetIsOpened = false
    @State private var alertIsPresented = false
    private func startAddNewEvent() {
        dataStore.setScreenMode(mode: .add)
        sheetIsOpened = true
    }

    // MARK: - View
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                if !allEvents.isEmpty {
                    EventsList()
                } else {
                    EventsListIsEmpyView {
                        startAddNewEvent()
                    }
                }
            }
            .navigationTitle("events".localized)
            .sheet(isPresented: $sheetIsOpened, content: {
                AddOrEditEventSheet(isOpened: $sheetIsOpened,
                                    showAlert: $alertIsPresented)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        startAddNewEvent()
                    }) {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.gray)
                    }
                    .contextMenu {
                        HelpContextMenu(helpText: "new_event")
                    }
                }
            }
            .alert(isPresented: $alertIsPresented, content: {
                NewAlert.showAlert {
                    dataStore.makeCurrentEventNil()
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

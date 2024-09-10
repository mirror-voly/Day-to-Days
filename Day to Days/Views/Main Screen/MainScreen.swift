//
//  ContentView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct MainScreen: View {
    @Environment(DataStore.self) private var dataStore
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
                if !dataStore.allEvents.isEmpty {
                    EventsList()
                } else {
                    EventsListIsEmpyView {
                        startAddNewEvent()
                    }
                }
            }
            .navigationTitle("Events")
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

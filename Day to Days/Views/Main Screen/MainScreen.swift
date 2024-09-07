//
//  ContentView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct MainScreen: View {
    @Environment(DataStore.self) private var dataStore
    @State var sheetIsOpened = false
    @State var alertIsPresented = false

    // MARK: - View
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(content: {
                    ForEach(dataStore.allEvents) { event in
                        NavigationLink(value: event) {
                            Divider()
                            EventsItemView(day: event)
                        }
                        .navigationDestination(for: Event.self) { event in
                            EventInfoScreen(event: event)
                                .navigationTitle(event.title)
                                .toolbarBackground(event.color.opacity(0.5), for: .navigationBar)
                                .toolbarBackground(.visible, for: .navigationBar)
                                .navigationBarBackButtonHidden()
                        }
                    }
                })
                .padding(.horizontal)
            }
            .navigationTitle("Events")
            .sheet(isPresented: $sheetIsOpened, content: {
                AddOrEditEventSheet(isOpened: $sheetIsOpened,
                                    showAlert: $alertIsPresented)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dataStore.screenMode = .add
                        sheetIsOpened = true
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

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
        NavigationView {
            ScrollView(.vertical) {
                VStack(content: {
                    ForEach(dataStore.allEvents) { event in
                        Divider()
                        EventsItemView(day: event)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                dataStore.screenMode = .edit
                                dataStore.currentEvent = event
                                sheetIsOpened = true
                            }
                    }
                })
                .padding(.horizontal)
            }
            .navigationTitle("Events")
            .sheet(isPresented: $sheetIsOpened, onDismiss: {
            }, content: {
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
                Alert(
                                title: Text("New event is not saved"),
                                message: Text("Are you shure that you mant to erese it"),
                                primaryButton: .destructive(Text("Yes")) {
                                    dataStore.screenMode = nil
                                },
                                secondaryButton: .default(Text("Cancel")) {
                                        sheetIsOpened = true
                                }
                            )
            })
        }
    }
}

#Preview {
    MainScreen()
}

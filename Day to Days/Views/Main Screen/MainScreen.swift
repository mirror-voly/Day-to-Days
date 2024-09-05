//
//  ContentView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct MainScreen: View {
    @Environment(DataStore.self) private var dataStore
    @State var editEventSheet = false
    @State var addNewSheetIsOpened = false
    @State var sheetCanDismiss = true
    @State var alertIsPresented = false
    @State var correntEvent: Event?
    private func checkIsSheetCanDismiss() {
        if !sheetCanDismiss {
            alertIsPresented = true
            sheetCanDismiss = true
        }
    }
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
                                correntEvent = event
                            }
                    }
                })
                .padding(.horizontal)
            }
            .navigationTitle("Events")
            .onChange(of: correntEvent, {
                editEventSheet = true
            })
            .sheet(isPresented: $addNewSheetIsOpened, onDismiss: {
                checkIsSheetCanDismiss()
            }, content: {
                AddOrEditEventSheet(isOpened: $addNewSheetIsOpened, 
                                    canDismiss: $sheetCanDismiss,
                                    isEditMode: false)
            })
            .sheet(isPresented: $editEventSheet, onDismiss: {
                checkIsSheetCanDismiss()
            }, content: {
                AddOrEditEventSheet(isOpened: $editEventSheet,
                                    canDismiss: $sheetCanDismiss,
                                    event: correntEvent,
                                    isEditMode: true)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        addNewSheetIsOpened = true
                    }) {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.gray)
                    }
                }
            }
            .alert(isPresented: $alertIsPresented, content: {
                Alert(title: Text("hi"))
            })
        }
    }
}

#Preview {
    MainScreen()
}

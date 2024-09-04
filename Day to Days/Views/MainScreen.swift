//
//  ContentView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct MainScreen: View {
    let dataStore = DataStore()
    @State var addNewSheetIsOpened = false
    @State var sheetCanDismiss = true
    @State var alertIsPresented = false
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(content: {
                    ForEach(dataStore.listOfDays, id: \.id) { day in
                        EventsItemView(day: day)
                        Divider()
                    }
                })
                .padding(.horizontal)
            }
            .navigationTitle("Events")
            .sheet(isPresented: $addNewSheetIsOpened, onDismiss: {
                if !sheetCanDismiss {
                    alertIsPresented = true
                    sheetCanDismiss = true
                }
            }, content: {
                AddNewCounterSheet(sheetIsOpened: $addNewSheetIsOpened, canDismiss: $sheetCanDismiss)
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

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
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(content: {
                    ForEach(dataStore.listOfDays, id: \.id) { day in
                        ContersListItemView(day: day)
                        Divider()
                    }
                })
                .padding(.horizontal)
            }
            .navigationTitle("Events")
            .sheet(isPresented: $addNewSheetIsOpened, content: {
                AddNewCounterSheet()
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
        }
    }
}

#Preview {
    MainScreen()
}

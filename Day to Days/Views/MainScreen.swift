//
//  ContentView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct MainScreen: View {
    let dataStore = DataStore()
    var body: some View {
        NavigationView {
                VStack {
                    List(dataStore.listOfDays) { day in
                        ContersListItem(day: day)
                    }
            }
            .navigationTitle("Counters")
        }
    }
}

#Preview {
    MainScreen()
}

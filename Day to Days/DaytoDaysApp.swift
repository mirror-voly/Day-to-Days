//
//  DaytoDaysApp.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

@main
struct DaytoDaysApp: App {
    @State private var dataStore = DataStore()
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environment(dataStore)
        }
    }
}

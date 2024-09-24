//
//  DaytoDaysApp.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

@main
struct DaytoDaysApp: App {
    @State private var mainScreenViewModel = MainScreenViewModel()
    @State private var addViewModel = AddOrEditEventSheetViewModel()
    var body: some Scene {
        WindowGroup {
            MainScreen(viewModel: mainScreenViewModel)
                .environment(mainScreenViewModel)
                .environment(addViewModel)
        }
    }
}

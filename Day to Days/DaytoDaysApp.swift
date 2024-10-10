//
//  DaytoDaysApp.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

@main
struct DaytoDaysApp: App {

    @State private var alertManager = AlertManager()
    @State private var mainScreenViewModel = MainScreenViewModel()

    var body: some Scene {

        WindowGroup {
            MainScreen(viewModel: mainScreenViewModel)
                .environment(mainScreenViewModel)
                .environment(alertManager)
                .alert(item: $alertManager.errorForAlert, content: { error in
                    alertManager.showAlert(identifiable: error)
                })
                .onAppear {
                    mainScreenViewModel.setAlertManager(alertManager: alertManager)
//                    addViewModel.setAlertManager(alertManager: alertManager)
                }
        }
    }
}

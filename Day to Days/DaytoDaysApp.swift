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

    var body: some Scene {

        WindowGroup {
            MainScreen()
                .environment(alertManager)
                .alert(item: $alertManager.errorForAlert, content: { error in
                    alertManager.showAlert(identifiable: error)
                })
        }
    }
}

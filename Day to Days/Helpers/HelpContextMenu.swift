//
//  HelpContextMenu.swift
//  Day to Days
//
//  Created by mix on 12.09.2024.
//

import SwiftUI

struct HelpContextMenu: View {
    let helpText: String
    var body: some View {
        Label("help".localized, systemImage: "info.circle")
        Text(helpText.localized)
    }
}

//
//  MainScreen+addNewButton.swift
//  Day to Days
//
//  Created by mix on 04.10.2024.
//

import SwiftUI

extension MainScreen {
    var addNewButton: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.sheetIsOpened = true
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundStyle(.gray)
                }
                .contextMenu {
                    HelpContextMenu(helpText: "new_event")
                }
            }
        }
    }
}

//
//  EventInfoScreen+toolbarItems.swift
//  Day to Days
//
//  Created by mix on 19.09.2024.
//

import SwiftUI

extension EventInfoScreen {
    var backButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                dismiss()
            } label: {
                Circle()
                    .fill(.white)
                    .frame(width: Constraints.buttonSize, height: Constraints.buttonSize)
                    .overlay(Image(systemName: "chevron.backward")
                        .fontWeight(.semibold))
            }
        }
    }

    var editButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                viewModel.editSheetIsOpened = true
            } label: {
                Circle()
                    .fill(.white)
                    .frame(width: Constraints.buttonSize, height: Constraints.buttonSize)
                    .overlay(Image(systemName: "pencil")
                        .fontWeight(.semibold))
            }
            .contextMenu {
                HelpContextMenu(helpText: "edit_event")
            }
        }
    }

    var notificationSettingsButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                viewModel.notificationSheetIsOpened = true
            } label: {
                Circle()
                    .fill(.white)
                    .frame(width: Constraints.buttonSize, height: Constraints.buttonSize)
                    .overlay(Image(systemName: "bell.fill")
                        .fontWeight(.semibold))
            }
            .contextMenu {
                HelpContextMenu(helpText: "notification_button_help")
            }
        }
    }
}

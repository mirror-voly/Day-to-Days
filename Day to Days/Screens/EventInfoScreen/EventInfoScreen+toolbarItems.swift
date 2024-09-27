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
                    .frame(width: Constraints.eventInfoButtonSize, height: Constraints.eventInfoButtonSize)
                    .overlay(Image(systemName: "chevron.backward")
                        .fontWeight(.semibold))
            }
        }
    }

    var editButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                sheetViewModel.setScreenMode(mode: .edit)
                viewModel.sheetIsOpened = true
            } label: {
                Circle()
                    .fill(.white)
                    .frame(width: Constraints.eventInfoButtonSize, height: Constraints.eventInfoButtonSize)
                    .overlay(Image(systemName: "pencil")
                        .fontWeight(.semibold))
            }
            .contextMenu {
                HelpContextMenu(helpText: "edit_event")
            }
        }
    }

    var widgetButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                WidgetManager.saveEventForWidget(viewModel.event)
            } label: {
                Circle()
                    .fill(.white)
                    .frame(width: Constraints.eventInfoButtonSize, height: Constraints.eventInfoButtonSize)
                    .overlay(Image(systemName: "pin.fill")
                        .font(.footnote))
            }
            .contextMenu {
                HelpContextMenu(helpText: "add_widget_help")
            }
        }
    }
}

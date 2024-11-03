//
//  EventsList+toolbar.swift
//  Day to Days
//
//  Created by mix on 19.09.2024.
//

import SwiftUI

// MARK: - Toolbar Items
extension EventsList {
    var sortMenu: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
				viewModel.settingsFullScreenCover = true
            } label: {
                Image(systemName: "gearshape.fill")
                    .foregroundStyle(.gray)
            }
        }
    }
	
    var editModeToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.removeSelectedEvents(completion: { result in
                        alertManager.getIdentifiebleErrorFrom(result: result)
                    })
                } label: {
                    Text(viewModel.noSelectedEvents ? "done".localized : "delete_selected".localized)
                }
                .buttonStyle(BorderedButtonStyle())
                .tint(.primary.opacity(Constraints.primaryOpacity))
            }
            if !viewModel.noSelectedEvents {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.makeSelectedEventsEmpty()
                    } label: {
                        Text("cancel".localized)
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .tint(.primary.opacity(Constraints.primaryOpacity))
                }
            }
        }
    }
}

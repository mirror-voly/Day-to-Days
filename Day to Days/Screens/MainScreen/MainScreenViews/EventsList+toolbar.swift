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
            Menu {
                ForEach(SortType.allCases, id: \.self) { type in
                    Button(role: .cancel) {
                        viewModel.sortButtonAction(type: type)
                    } label: {
                        HStack {
                            Text(type.rawValue.localized)
                            Image(systemName: type != .none ? viewModel.imageName : "dot.circle")
                        }
                    }
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down.circle")
                    .foregroundStyle(.gray)
            }
        }
    }

    var editModeToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.setEditMode(mode: .inactive)
                    viewModel.removeSelectedEvents()
                } label: {
                    Text(viewModel.noSelectedEvents ? "done".localized : "delete_selected".localized)
                }
                .buttonStyle(BorderedButtonStyle())
                .tint(.primary.opacity(Сonstraints.primaryOpacity))
            }
            if !viewModel.noSelectedEvents {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.makeSelectedEventsEmpty()
                        viewModel.setEditMode(mode: .inactive)
                    } label: {
                        Text("cancel".localized)
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .tint(.primary.opacity(Сonstraints.primaryOpacity))
                }
            }
        }
    }
}

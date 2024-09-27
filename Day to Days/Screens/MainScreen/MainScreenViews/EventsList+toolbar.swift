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
                ForEach(SortType.allCases, id: \.self) { sortType in
                    Button(role: .cancel) {
                        viewModel.sortButtonAction(type: sortType)
                    } label: {
                        HStack {
                            Text(sortType.rawValue.localized)
                            Image(systemName: sortType != .none ? viewModel.imageName : "dot.circle")
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
                    viewModel.removeSelectedEvents()
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

//
//  EventsList+swipeButtons.swift
//  Day to Days
//
//  Created by mix on 19.09.2024.
//

import SwiftUI

// MARK: - Toolbar Items
extension EventsList {
    // MARK: Swipe Actions
    func deleteButton(_ eventID: UUID) -> some View {
        Button(role: .destructive) {
            viewModel.removeEventBy(eventID, completion: { result in
                alertManager.getIdentifiebleErrorFrom(result: result)
            })
        } label: {
            Label("delete".localized, systemImage: "trash")
        }
    }

    func multipleSelectionButton() -> some View {
        Button(role: .cancel) {
            viewModel.setEditMode(set: true)
        } label: {
            Label("multiple_selection".localized, systemImage: "checkmark.circle")
        }
    }
}

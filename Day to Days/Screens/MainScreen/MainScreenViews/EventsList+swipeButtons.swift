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
    func deleteButton(for event: Event) -> some View {
        Button(role: .destructive) {
            $allEvents.remove(event)
        } label: {
            Label("delete".localized, systemImage: "trash")
        }
    }

    func multipleSelectionButton() -> some View {
        Button(role: .cancel) {
            viewModel.setEditMode(mode: .active)
        } label: {
            Label("multiple_selection".localized, systemImage: "checkmark.circle")
        }
    }
}

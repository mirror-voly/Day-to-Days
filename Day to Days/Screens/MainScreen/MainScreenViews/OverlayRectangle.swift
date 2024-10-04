//
//  OverlayRectangle.swift
//  Day to Days
//
//  Created by mix on 24.09.2024.
//

import SwiftUI

struct OverlayRectangle: View {
    @Environment(EventsItemViewModel.self) private var viewModel
    var body: some View {
        Rectangle()
            .fill(viewModel.selectedColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipShape(.rect(cornerRadius: Constraints.cornerRadius))
            .onTapGesture {
                viewModel.toggleSelected()
            }
    }
}

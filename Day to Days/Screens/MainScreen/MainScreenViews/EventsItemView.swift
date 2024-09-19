//
//  EventsItemView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct EventsItemView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(MainScreenViewModel.self) private var mainScreenViewModel
    @State private var viewModel = EventsItemViewModel()
    let event: Event

    var body: some View {
        HStack {
            // MARK: - Circle
            Circle()
                .fill(event.color)
                .overlay(
                    Circle()
                        .fill(colorScheme == .light ? (viewModel.isSelected ? Color.primary : .white) :
                                (viewModel.isSelected ? Color.primary : .black))
                        .frame(width: Сonstraints.eventsItemViewCicleHoleSize))
                .frame(width: Сonstraints.eventsItemViewCicleSize)
                .padding()
                .onChange(of: mainScreenViewModel.editMode) { _, newValue in
                    if newValue != .active {
                        viewModel.changeSelectedToFalse()
                    }
                }
            Text(event.title)
                .font(.title2)
            Spacer()
            DayCounterWithShortInfoView(color: event.color)
        }
        .overlay(alignment: .center) {
                if mainScreenViewModel.editMode == .active {
                    Rectangle()
                        .fill(viewModel.isSelected ? Color.primary.opacity(0.1) : Color.primary.opacity(0.01))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipShape(.rect(cornerRadius: Сonstraints.cornerRadius))
                        .onTapGesture {
                            mainScreenViewModel.toggleSelectedState(eventID: event.id)
                            viewModel.toggleSelected()
                        }
                }
        }
        .onAppear {
            viewModel.setTimeData(event: event)
        }
        .onChange(of: viewModel.isSelected) { _, _ in
            mainScreenViewModel.toggleSelection(eventID: event.id, isSelected: viewModel.isSelected)
        }
        .environment(viewModel)
    }
}

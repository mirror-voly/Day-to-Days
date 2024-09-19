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
                ZStack(alignment: .center, content: {
                        Circle()
                        .fill(event.color)
                            .overlay(
                                Circle()
                                    .fill(colorScheme == .light ? (viewModel.isSelected ? Color.primary : .white) :
                                            (viewModel.isSelected ? Color.primary : .black))
                                .frame(width: Сonstraints.eventsItemViewCicleHoleSize))
                })
                .frame(width: Сonstraints.eventsItemViewCicleSize)
                .padding()
                .onChange(of: mainScreenViewModel.editMode) { _, newValue in
                    if newValue != .active {
                        viewModel.changeSelectedToFalse()
                    }
                }
                .onChange(of: viewModel.isSelected) { _, _ in
                    mainScreenViewModel.toggleSelection(eventID: event.id, isSelected: viewModel.isSelected)
                }
            // MARK: - Title
                Text(event.title)
                    .font(.title2)
            Spacer()
            // MARK: - Day counter
                            VStack {
                                Text(viewModel.localizedTimeState)
                                    .minimumScaleFactor(Сonstraints.dateTextMinimumScaleFactor)
                                    .lineLimit(1)
                                Divider()
                                Text(viewModel.number)
                                    .foregroundStyle(event.color)
                                    .bold()
                                    .font(.title3)
                                    .frame(maxWidth: .infinity)
                                    .minimumScaleFactor(Сonstraints.dateTextMinimumScaleFactor)
                                    .lineLimit(1)
                                Text(viewModel.localizedDateType)
                                    .italic()
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                            .frame(width: Сonstraints.eventsItemViewDateFrameSize)
                            .padding()
        }
        .overlay(alignment: .center) {
            Group {
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
        }
        .onAppear {
            viewModel.setTimeData(event: event)
        }
    }
}

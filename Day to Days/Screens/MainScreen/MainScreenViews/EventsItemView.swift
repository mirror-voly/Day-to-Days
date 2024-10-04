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
    @State private var viewModel: EventsItemViewModel

    var body: some View {
        HStack {
            // MARK: Circle
            Circle()
                .fill(viewModel.event.color)
                .overlay(
                    Circle()
                        .fill(viewModel.fillColor)
                        .frame(width: Constraints.eventsItemViewCicleHoleSize))
                .frame(width: Constraints.eventsItemViewCicleSize)
                .padding()
                .onChange(of: mainScreenViewModel.editIsActivated) { _, newValue in
                    guard !newValue else { return }
                    viewModel.changeSelectedToFalse()
                }
            Text(viewModel.event.title)
                .font(.title2)
            Spacer()
            // MARK: Counter
            DayCounterWithShortInfoView()
        }
        .overlay(alignment: .center) {
            if mainScreenViewModel.editIsActivated {
                OverlayRectangle()
            }
        }
        .onChange(of: mainScreenViewModel.sortedEvents, { _, _ in
            viewModel.updateEvent()
        })
        .onAppear {
            viewModel.setMainViewModel(mainScreenViewModel)
        }
        .environment(viewModel)
    }

    init(index: Int) {
        _viewModel = State(wrappedValue: EventsItemViewModel(index: index))
    }
}

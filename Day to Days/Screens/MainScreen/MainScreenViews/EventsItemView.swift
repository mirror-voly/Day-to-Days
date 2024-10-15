//
//  EventsItemView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct EventsItemView: View {
    private var mainScreenViewModel: MainScreenViewModel
    @State private var viewModel: EventsItemViewModel

    var body: some View {
        GeometryReader { proxy in
            HStack {
                // MARK: Circle
                Circle()
                    .fill(viewModel.color)
                    .overlay(
                        Circle()
                            .fill(viewModel.circleHoleColor)
                            .frame(width: Constraints.eventsItemViewCicleHoleSize))
                    .frame(width: Constraints.eventsItemViewCicleSize)
                    .padding()
                    .onChange(of: mainScreenViewModel.editIsActivated) { _, newValue in
                        guard !newValue else { return }
                        viewModel.changeSelectedToFalse()
                    }
                Text(viewModel.title)
                    .font(.title2)
                Spacer()
                // MARK: Counter
                DayCounterWithShortInfoView()
            }
            .onChange(of: proxy.frame(in: .global), { _, _ in
                viewModel.isOutOfBounds(proxy: proxy)
            })
            .blur(radius: viewModel.isVisible ? Constraints.originalSize: .zero)
            .opacity(viewModel.isVisible ?
                     Constraints.listItemAnimationScale: Constraints.originalSize)
            .scaleEffect(viewModel.isVisible ?
                         Constraints.listItemAnimationScale: Constraints.originalSize)
            .animation(.linear, value: viewModel.isVisible)
        }
        .frame(height: Constraints.eventsItemViewHeight)
        .overlay(alignment: .center) {
            if mainScreenViewModel.editIsActivated {
                OverlayRectangle()
            }
        }
        .environment(viewModel)
    }

    init(event: Event, mainScreenViewModel: MainScreenViewModel) {
        self.viewModel = EventsItemViewModel(event: event, mainScreenViewModel: mainScreenViewModel)
        self.mainScreenViewModel = mainScreenViewModel
    }
}

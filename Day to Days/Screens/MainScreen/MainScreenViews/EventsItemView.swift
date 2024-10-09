//
//  EventsItemView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct EventsItemView: View {
    @Environment(MainScreenViewModel.self) private var mainScreenViewModel
    @State private var viewModel: EventsItemViewModel

    var body: some View {
        GeometryReader { proxy in
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
        .frame(height: 115)
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

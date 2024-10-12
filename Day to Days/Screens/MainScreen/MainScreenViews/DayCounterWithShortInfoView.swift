//
//  DayCounterWithShortInfoView.swift
//  Day to Days
//
//  Created by mix on 19.09.2024.
//

import SwiftUI

struct DayCounterWithShortInfoView: View {
    @Environment(EventsItemViewModel.self) private var viewModel
    var body: some View {
        VStack {
            Group {
                Text(viewModel.localizedTimeState)
                Divider()
                Text(viewModel.number)
                    .foregroundStyle(viewModel.color)
                    .bold()
                    .font(.title3)
                Text(viewModel.localizedDateType)
                    .italic()
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity)
            .minimumScaleFactor(Constraints.dateTextMinimumScaleFactor)
        }
        .frame(width: Constraints.eventsItemViewDateFrameSize)
        .padding()
    }
}

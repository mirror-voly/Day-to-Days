//
//  DayCounterWithShortInfoView.swift
//  Day to Days
//
//  Created by mix on 19.09.2024.
//

import SwiftUI

struct DayCounterWithShortInfoView: View {
    @Environment(EventsItemViewModel.self) private var viewModel
    let color: Color
    var body: some View {
        VStack {
            Group {
                Text(viewModel.localizedTimeState)
                    .minimumScaleFactor(Сonstraints.dateTextMinimumScaleFactor)
                Divider()
                Text(viewModel.number)
                    .foregroundStyle(color)
                    .bold()
                    .font(.title3)
                    .minimumScaleFactor(Сonstraints.dateTextMinimumScaleFactor)
                Text(viewModel.localizedDateType)
                    .italic()
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity)
        }
        .frame(width: Сonstraints.eventsItemViewDateFrameSize)
        .padding()
    }
}

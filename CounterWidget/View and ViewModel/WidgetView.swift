//
//  WidgetView.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.
//

import SwiftUI

struct WidgetView: View {
    var viewModel: WidgetViewModel

    var body: some View {
            VStack (spacing: Constraints.widgetStackSpaser) {
                Group {
                    Text(viewModel.eventTitle)
                        .minimumScaleFactor(Constraints.dateTextMinimumScaleFactor)
                        .foregroundStyle(.gray)
                    Divider()
                    Text(viewModel.number)
                        .font(.system(size: Constraints.widgetNumberFontSize, weight: .heavy))
//                        .foregroundStyle(viewModel.numberColor)
                        .minimumScaleFactor(Constraints.dateTextMinimumScaleFactor)
                    Divider()
                    HStack(spacing: Constraints.widgetStackSpaser, content: {
                        Group {
                            Text(viewModel.localizedDateType.capitalized)
                            Text(viewModel.localizedTimeState)
                        }
                        .italic()
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    })
                }
                .lineLimit(1)
            }
            .ignoresSafeArea()
    }
    init(events: [EventWidget], eventID: String) {
        self.viewModel = WidgetViewModel(events: events, eventID: eventID)
    }
}

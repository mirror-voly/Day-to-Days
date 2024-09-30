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
            Text(viewModel.event.name)
                .lineLimit(1)
                .minimumScaleFactor(Constraints.dateTextMinimumScaleFactor)
                .foregroundStyle(.gray)
            Divider()
            Text(viewModel.number)
                .font(.system(size: Constraints.widgetNumberFontSize, weight: .heavy))
                .lineLimit(1)
                .foregroundStyle(viewModel.numberColor)
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
        .ignoresSafeArea()
    }
    init(event: EventWidget, numberColor: Color) {
        self.viewModel = WidgetViewModel(event: event, numberColor: numberColor)
    }
}

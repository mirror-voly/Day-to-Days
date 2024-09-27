//
//  WidgetView.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.
//

import SwiftUI

struct WidgetView: View {
    var viewModel = WidgetViewModel()
    let numberColor: Color
    let event: EventWidget

    var body: some View {
        VStack (spacing: Constraints.widgetStackSpaser) {
            Text(event.name)
                .lineLimit(1)
                .minimumScaleFactor(Constraints.dateTextMinimumScaleFactor)
                .foregroundStyle(.gray)
            Divider()
            Text(viewModel.number)
                .font(.system(size: Constraints.widgetNumberFontSize, weight: .heavy))
                .lineLimit(1)
                .foregroundStyle(numberColor)
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
        .onAppear(perform: {
            viewModel.setTimeData(event: event)
        })
        .ignoresSafeArea()
    }
}

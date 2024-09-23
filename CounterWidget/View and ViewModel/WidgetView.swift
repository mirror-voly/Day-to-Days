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
        VStack (spacing: Сonstraints.widgetStackSpaser) {
            Text(event.name)
                .lineLimit(1)
                .minimumScaleFactor(Сonstraints.dateTextMinimumScaleFactor)
                .foregroundStyle(.gray)
            Divider()
            Text(viewModel.number)
                .font(.system(size: Сonstraints.widgetNumberFontSize, weight: .heavy))
                .lineLimit(1)
                .foregroundStyle(numberColor)
                .minimumScaleFactor(Сonstraints.dateTextMinimumScaleFactor)
            Divider()
            HStack(spacing: Сonstraints.widgetStackSpaser, content: {
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

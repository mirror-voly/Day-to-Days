//
//  MainWidgetView.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.
//

import SwiftUI

struct MainWidgetView: View {
    private let viewModel: WidgetViewModel

    var body: some View {
            VStack (spacing: Constraints.widgetStackSpaser) {
                Group {
                    Text(viewModel.eventTitle)
                        .foregroundStyle(.gray)
                    Divider()
                    Text(viewModel.number)
                        .font(.system(size: Constraints.widgetNumberFontSize, weight: .heavy))
                        .foregroundStyle(viewModel.color)
                    Divider()
                    HStack(spacing: Constraints.widgetStackSpaser, content: {
                        Group {
                            Text((viewModel.localizedDateType + viewModel.localizedTimeState).capitalizedFirstLetter())
                        }
                        .italic()
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    })
                }
                .minimumScaleFactor(Constraints.dateTextMinimumScaleFactor)
                .lineLimit(1)
            }
            .ignoresSafeArea()
    }
    init(viewModel: WidgetViewModel) {
        self.viewModel = viewModel
    }
}

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
        if viewModel.eventID != nil {
            VStack (spacing: Constraints.widgetStackSpaser) {
                Group {
                    Text(viewModel.event.name)
                        .minimumScaleFactor(Constraints.dateTextMinimumScaleFactor)
                        .foregroundStyle(.gray)
                    Divider()
                    Text(viewModel.number)
                        .font(.system(size: Constraints.widgetNumberFontSize, weight: .heavy))
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
                .lineLimit(1)
            }
            .ignoresSafeArea()
        } else {
            Button(intent: IncreaseCounter()) {
                Text("Up")
            }
            Button(intent: DecriseCounter()) {
                Text("Down")
            }
        }
        
    }
    init(event: EventWidget, numberColor: Color) {
        self.viewModel = WidgetViewModel(event: event, numberColor: numberColor)
    }
}

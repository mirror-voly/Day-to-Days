//
//  WidgetView.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.
//

import SwiftUI

struct WidgetView: View {
    @State var viewModel = WidgetViewModel()
    let event: EventWidget

    var body: some View {
        VStack (spacing: 0) {
                Text(event.name)
                    .lineLimit(1)
                    .minimumScaleFactor(Сonstraints.dateTextMinimumScaleFactor)
                Divider()
                Text(viewModel.number)
                    .bold()
                    .fontWeight(.heavy)
                    .font(.custom("", fixedSize: 80))
                    .minimumScaleFactor(Сonstraints.dateTextMinimumScaleFactor)
            HStack(content: {
                Group {
                    Text(viewModel.localizedDateType)
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

#Preview {
    WidgetView(event: EventWidget(name: "Title", id: UUID(), date: Date(), dateType: .day))
}

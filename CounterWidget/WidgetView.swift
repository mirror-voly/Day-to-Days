//
//  WidgetView.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.
//

import SwiftUI

struct WidgetView: View {
//    @State var viewModel = WidgetViewModel()
    let event: EventWidget

    var body: some View {
        VStack {
            Text(event.name)
                .bold()
            Divider()
            Text(event.date.formatted())
                .minimumScaleFactor(Сonstraints.dateTextMinimumScaleFactor)
            Divider()
            Text(event.date.formatted(.dateTime.day()))
                .bold()
                .font(.largeTitle)
                .minimumScaleFactor(Сonstraints.dateTextMinimumScaleFactor)
            Text("ago")
                .italic()
                .font(.footnote)
                .foregroundStyle(.gray)
        }
//        .onAppear(perform: {
//            viewModel.setTimeData(event: event)
//        })
    }
}

#Preview {
    WidgetView(event: EventWidget(name: "Title", id: UUID(), date: Date()))
}

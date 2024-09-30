//
//  DateInfoView.swift
//  Day to Days
//
//  Created by mix on 10.09.2024.
//

import SwiftUI

struct DateInfoView: View {
    let number: String
    let label: String

    var body: some View {
        VStack {
            Text(number)
                .lineLimit(1)
                .font(.title)
                .minimumScaleFactor(Constraints.dateTextMinimumScaleFactor)
                .contentTransition(.numericText())
            Text(label)
                .italic()
                .font(.footnote)
                .foregroundStyle(Color.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    init(number: String, dateType: DateType, viewModel: EventInfoScreenViewModel) {
        self.number = number
        self.label = viewModel.dateCalculator.localizeIt(for: number, unit: dateType.label)
    }
}

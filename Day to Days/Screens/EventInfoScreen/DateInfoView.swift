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

	init(number: String, dateType: DateType, dateCalculator: DateCalculator) {
        self.number = number
        self.label = dateCalculator.localizeIt(for: number, dateType: dateType)
    }
}

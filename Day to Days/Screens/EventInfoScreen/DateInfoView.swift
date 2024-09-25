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
                .minimumScaleFactor(Сonstraints.dateTextMinimumScaleFactor)
            Text(label)
                .italic()
                .font(.footnote)
                .foregroundStyle(Color.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    init(number: String, dateType: DateType) {
        self.number = number
        self.label = TimeUnitLocalizer.localizeIt(for: number, unit: dateType.label)
    }
}

//
//  DateInfoView.swift
//  Day to Days
//
//  Created by mix on 10.09.2024.
//

import SwiftUI

struct DateInfoView: View {
    private let scaleFactor = Constants.Сonstraints.dateTextMinimumScaleFactor
    let value: String
    let label: String

    var body: some View {
        VStack {
            Text(value)
                .lineLimit(1)
                .font(.title)
                .minimumScaleFactor(scaleFactor)
            Text(label)
                .italic()
                .font(.footnote)
                .foregroundStyle(Color.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

//
//  EmptyWidgetView.swift
//  CounterWidgetExtension
//
//  Created by mix on 03.10.2024.
//

import SwiftUI

struct EmptyWidgetView: View {
    var body: some View {
        Group {
            Text("setup".localized)
                .font(.title2)
            Divider()
            Image(systemName: "hand.tap")
                .font(.title)
            Text("tap".localized)
                .font(.footnote)
        }
        .minimumScaleFactor(Constraints.dateTextMinimumScaleFactor)
        .multilineTextAlignment(.center)
        .foregroundStyle(.gray)
    }
}

#Preview {
    EmptyWidgetView()
}

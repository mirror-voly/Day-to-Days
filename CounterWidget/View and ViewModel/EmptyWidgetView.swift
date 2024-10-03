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
            Text("Setup")
                .font(.title2)
            Divider()
            Text("Tap and hold on widget screen")
                .font(.footnote)
            Image(systemName: "hand.tap")
        }
        .minimumScaleFactor(Constraints.dateTextMinimumScaleFactor)
        .multilineTextAlignment(.center)
        .foregroundStyle(.gray)
    }
}

#Preview {
    EmptyWidgetView()
}

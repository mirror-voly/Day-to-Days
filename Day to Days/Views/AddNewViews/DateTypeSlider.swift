//
//  DateTypeSlider.swift
//  Day to Days
//
//  Created by mix on 05.09.2024.
//

import SwiftUI

struct DateTypeSlider: View {
    @Binding var sliderValue: Int
    @Binding var dateType: Event.DateType
    var body: some View {
        GroupBox {
            // MARK: - Counter Hstack
            HStack(alignment: .center, content: {
                Text("Сount")
                Spacer()
                Text(dateType.rawValue)
            })
            // MARK: - Slider
            Slider(value: Binding(
                            get: { Double(sliderValue) },
                            set: { newValue in
                                sliderValue = Int(newValue)
                                dateType = .allCases[sliderValue]
                            }
            ), in: 0...Double(Event.DateType.allCases.count - 1), step: 1)
            // MARK: - Underline text
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                Group {
                    Text("Day")
                    Spacer()
                    Text("Weak")
                    Spacer()
                    Text("Month")
                    Spacer()
                    Text("Year")
                }
                .fixedSize()
                .lineLimit(1)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
            })
        }
    }
}

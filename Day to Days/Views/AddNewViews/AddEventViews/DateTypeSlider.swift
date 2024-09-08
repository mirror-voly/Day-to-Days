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
    @Binding var sliderColor: Color
    let circleSize = Constants.Сonstraints.sliderCircleSize
    var body: some View {
        GroupBox {
            // MARK: - Counter Hstack
            HStack(alignment: .center, content: {
                Text("Сount")
                Spacer()
                Text(dateType.rawValue)
            })
            // MARK: - Slider
            ZStack(alignment: .center) {
                HStack(content: {
                    Group {
                        Circle()
                            .frame(width: circleSize, height: circleSize)
                        Spacer()
                        Circle()
                            .frame(width: circleSize, height: circleSize)
                        Spacer()
                        Circle()
                            .frame(width: circleSize, height: circleSize)
                        Spacer()
                        Circle()
                            .frame(width: circleSize, height: circleSize)
                    }
                    .foregroundStyle(.gray)
                })
                .disabled(true)
                .frame(maxWidth: .infinity)
                Slider(value: Binding(
                                get: { Double(sliderValue) },
                                set: { newValue in
                                    sliderValue = Int(newValue)
                                    dateType = .allCases[sliderValue]
                                }
                ), in: 0...Double(Event.DateType.allCases.count - 1), step: 1)
                .tint(sliderColor)
            }
            // MARK: - Underline text
            HStack(content: {
                Group {
                    Text("Day")
                        .fixedSize()
                    Spacer()
                    Text("Weak")
                        .fixedSize()
                        .padding(.leading, Constants.Сonstraints.sliderTextPadding)
                    Spacer()
                    Text("Month")
                        .fixedSize()
                        .padding(.leading, Constants.Сonstraints.sliderTextPadding)
                    Spacer()
                    Text("Year")
                        .fixedSize()
                }
                .lineLimit(1)
                .foregroundStyle(.secondary)
            })
            .frame(maxWidth: .infinity)
        }
    }
}

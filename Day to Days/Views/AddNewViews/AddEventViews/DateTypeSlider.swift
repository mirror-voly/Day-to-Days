//
//  DateTypeSlider.swift
//  Day to Days
//
//  Created by mix on 05.09.2024.
//

import SwiftUI

struct DateTypeSlider: View {
    @Binding var sliderValue: Double
    @Binding var dateType: Event.DateType
    @Binding var sliderColor: Color
    private let circleSizeNormal = Constants.Сonstraints.sliderCircleSizeNornmal
    private let circleSizeMaximized = Constants.Сonstraints.sliderCircleSizeMaximazed

    private func fillCircles(step: Int, sum: Int) -> some View {
            HStack {
                ForEach(0..<sum) { index in
                    VStack {
                        Button(action: {
                            sliderValue = Double(index)
                            dateType = .allCases[index]
                        }, label: {
                            Circle()
                                .fill(index < step + 1 ? sliderColor : .gray)
                                .frame(width: index < step + 1 ? circleSizeMaximized : circleSizeNormal)
                        })
                        .containerShape(Rectangle())
                    }
                    .frame(width: 25)
                    if index < sum - 1 {
                        Spacer()
                    }
                }
            }
        }

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
                Slider(value: $sliderValue, in: 0...Double(Event.DateType.allCases.count - 1), step: 1)
                .tint(sliderColor)
                .allowsHitTesting(false)

                fillCircles(step: Int(sliderValue), sum: 4)
                    .frame(maxWidth: .infinity)
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

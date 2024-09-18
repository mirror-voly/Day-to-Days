//
//  DateTypeSlider.swift
//  Day to Days
//
//  Created by mix on 05.09.2024.
//

import SwiftUI

struct DateTypeSlider: View {
    @Environment(AddOrEditEventSheetViewModel.self) private var sheetViewModel
    private let circleSizeNormal = Сonstraints.sliderCircleSizeNornmal
    private let circleSizeMaximized = Сonstraints.sliderCircleSizeMaximazed

    var body: some View {
        GroupBox {
            // MARK: - Counter Hstack
            HStack(alignment: .center, content: {
                Text("count".localized)
                Spacer()
                Text(sheetViewModel.dateType.label.localized.capitalized)
            })
            // MARK: - Slider
            ZStack(alignment: .center) {
                Slider(value: Binding(get: {
                    sheetViewModel.sliderValue
                }, set: { value in
                    sheetViewModel.sliderValue = value
                }), in: 0...Double(DateType.allCases.count - 1), step: 1)
                    .tint(sheetViewModel.color)
                .allowsHitTesting(false)

                fillSliderCircles(step: Int(sheetViewModel.sliderValue), sum: DateType.allCases.count)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

extension DateTypeSlider {
    private func fillSliderCircles(step: Int, sum: Int) -> some View {
            HStack {
                ForEach(0..<sum, id: \.self) { index in
                    let helpString = sheetViewModel.addHelpToTheButtonsBy(index)
                    VStack {
                        Button(action: {
                            sheetViewModel.sliderValue = Double(index)
                            sheetViewModel.dateType = .allCases[index]
                        }, label: {
                            Circle()
                                .fill(index < step + 1 ? sheetViewModel.color : .gray)
                                .frame(width: index < step + 1 ? circleSizeMaximized : circleSizeNormal)
                        })
                        .containerShape(Rectangle())
                        .contextMenu {
                            HelpContextMenu(helpText: helpString)
                        }
                    }
                    .frame(width: circleSizeMaximized - 5)
                    if index < sum - 1 {
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
}

//
//  DateTypeSlider.swift
//  Day to Days
//
//  Created by mix on 05.09.2024.
//

import SwiftUI

struct DateTypeSlider: View {
    @Environment(AddOrEditEventSheetViewModel.self) private var viewModel
    private let circleSizeNormal = Сonstraints.sliderCircleSizeNornmal
    private let circleSizeMaximized = Сonstraints.sliderCircleSizeMaximazed

    var body: some View {
        GroupBox {
            // MARK: - Counter Hstack
            HStack(alignment: .center, content: {
                Text("count".localized)
                Spacer()
                Text(viewModel.dateType.label.localized.capitalized)
            })
            // MARK: - Slider
            ZStack(alignment: .center) {
                Slider(value: Binding(get: {
                    viewModel.sliderValue
                }, set: { value in
                    viewModel.sliderValue = value
                }), in: 0...Double(DateType.allCases.count - 1), step: 1)
                .tint(viewModel.color)
                .allowsHitTesting(false)
                fillSliderCircles(step: Int(viewModel.sliderValue), sum: DateType.allCases.count)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

extension DateTypeSlider {
    private func fillSliderCircles(step: Int, sum: Int) -> some View {
        HStack {
            ForEach(0..<sum, id: \.self) { index in
                let helpString = viewModel.addHelpToTheButtonsBy(index)
                VStack {
                    Button(action: {
                        viewModel.sliderValue = Double(index)
                        viewModel.dateType = .allCases[index]
                    }, label: {
                        Circle()
                            .fill(index < step + 1 ? viewModel.color : .gray)
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

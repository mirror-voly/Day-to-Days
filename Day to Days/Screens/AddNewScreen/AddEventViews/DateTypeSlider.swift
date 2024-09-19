//
//  DateTypeSlider.swift
//  Day to Days
//
//  Created by mix on 05.09.2024.
//

import SwiftUI

struct DateTypeSlider: View {
    @Environment(AddOrEditEventSheetViewModel.self) var viewModel

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
                    viewModel.setSliderValue(value: value)
                }), in: 0...Double(DateType.allCases.count - 1), step: 1)
                .tint(viewModel.color)
                .allowsHitTesting(false)

                fillSliderCircles(step: Int(viewModel.sliderValue), sum: DateType.allCases.count)
            }
        }
    }
}

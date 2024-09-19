//
//  DateTipeSlider+Circles.swift
//  Day to Days
//
//  Created by mix on 19.09.2024.
//

import SwiftUI

extension DateTypeSlider {
    func fillSliderCircles(step: Int, sum: Int) -> some View {
        HStack {
            ForEach(0..<sum, id: \.self) { index in
                VStack {
                    Button(action: {
                        viewModel.setSliderValue(value: Double(index))
                    }, label: {
                        Circle()
                            .fill(index < step + 1 ? viewModel.color : .gray)
                            .frame(width: index < step + 1 ? Сonstraints.sliderCircleBig: Сonstraints.sliderCircleSmall)
                    })
                    .containerShape(Rectangle())
                    .contextMenu {
                        HelpContextMenu(helpText: viewModel.addHelpToTheButtonsBy(index))
                    }
                }
                .frame(width: Сonstraints.sliderCircleBig - 5)
                if index < sum - 1 {
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

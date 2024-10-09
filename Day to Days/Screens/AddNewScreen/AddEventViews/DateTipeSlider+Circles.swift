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
                        withAnimation {
                            viewModel.setSliderValue(value: Double(index))
                        }
                    }, label: {
                        let needToColorize = index < step + 1
                        Circle()
                            .fill(needToColorize ? viewModel.color : .gray)
                            .frame(width: needToColorize ? Constraints.sliderCircleBig: Constraints.sliderCircleSmall)
                    })
                    .containerShape(Rectangle())
                    .contextMenu {
                        HelpContextMenu(helpText: viewModel.addHelpToTheButtonsBy(index))
                    }
                }
                .frame(width: Constraints.sliderCircleBig - 5)
                if index < sum - 1 {
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

//
//  ColorPicker.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct ColorPicker: View {
    @Bindable var viewModel: AddOrEditEventSheetViewModel

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, content: {
                ForEach(ColorType.allCases, id: \.self) { currentColor in
                    Button(action: {
                        viewModel.setColor(color: currentColor.getColor)
                    }, label: {
                        Image(systemName: "largecircle.fill.circle")
                            .font(.title)
                            .foregroundStyle(currentColor.getColor)
                            .overlay(content: {
                                Circle()
                                    .fill(viewModel.getColorForMenuItem(currentColor: currentColor))
                                    .frame(width: Constraints.eventsItemViewCicleHoleSize)
                            })
                    })
                    .scrollTransition { content, phase in
                        content
                            .scaleEffect(phase.isIdentity ? Constraints.originalSize :
                                            Constraints.scaleColorItem)
                    }
                    .contextMenu {
                        HelpContextMenu(helpText: "color_help")
                    }
                }
                .containerRelativeFrame(.horizontal,
                                        count: 8,
                                        spacing: Constraints.containerRelativeFrame)
            })
            .scrollTargetLayout()
        }
        .contentMargins(Constraints.containerRelativeFrame, for: .scrollContent)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
    }
}

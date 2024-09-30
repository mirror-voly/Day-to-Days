//
//  ColorPickerPopover.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct ColorPickerPopover: View {
    @Bindable var viewModel: AddOrEditEventSheetViewModel

    var body: some View {
        HStack(content: {
            Text("color".localized)

            Spacer()

            Button(action: {
                viewModel.toggleIsPresented()
            }, label: {
                Text(viewModel.color.getColorType.rawValue.localized)
                Image(systemName: "pencil.tip.crop.circle.fill")
            })
            .foregroundStyle(viewModel.color)
            .contextMenu {
                HelpContextMenu(helpText: "color_help")
            }
            // MARK: Color popover
            .popover(isPresented: $viewModel.popoverIsPresented, content: {
                ScrollView {
                    VStack(alignment: .trailing, content: {
                        ForEach(ColorType.allCases, id: \.self) { currentColor in
                            Button(action: {
                                viewModel.setColor(color: currentColor.getColor)
                                viewModel.setPopoverIsPresented(set: false)
                            }, label: {
                                HStack(alignment: .center) {
                                    Group {
                                        Text(currentColor.rawValue.localized)
                                        Image(systemName: "pencil.tip.crop.circle.fill")
                                    }
                                    .foregroundStyle(currentColor.getColor)
                                }
                            })
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .background(viewModel.getColorForMenuItem(currentColor: currentColor))
                            Divider()
                        }
                    })
                    .padding()
                }
                .presentationCompactAdaptation(.popover)
            })
        })
    }
}

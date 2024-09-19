//
//  ColorPickerPopover.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct ColorPickerPopover: View {
    @Environment(AddOrEditEventSheetViewModel.self) private var viewModel

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
            .popover(isPresented: Binding(get: {
                viewModel.popoverIsPresented
            }, set: { value in
                viewModel.setPopoverIsPresented(set: value)
            }), content: {
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
                            .background(viewModel.color.getColorType == currentColor ? Color.secondary : Color.clear)
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

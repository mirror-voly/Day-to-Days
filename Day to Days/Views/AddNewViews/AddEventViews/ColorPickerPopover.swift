//
//  ColorPickerPopover.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct ColorPickerPopover: View {
    @State var popoverIsPresented = false
    @Binding var color: Color

    var body: some View {
        HStack(content: {
            Text("color".localized)
            Spacer()
            Button(action: {
                popoverIsPresented.toggle()
            }, label: {
                Text(color.getColorType.rawValue.localized)
                Image(systemName: "pencil.tip.crop.circle.fill")
            })
            .foregroundStyle(color)
            .contextMenu {
                HelpContextMenu(helpText: "color_help")
            }
            // MARK: Color popover
            .popover(isPresented: $popoverIsPresented, content: {
                VStack {
                    VStack(alignment: .trailing, content: {
                        ForEach(ColorType.allCases, id: \.self) { currentColor in
                            let isSelected = color.getColorType == currentColor
                            Button(action: {
                                color = currentColor.getColor
                                popoverIsPresented = false
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
                            .background(isSelected ? Color.secondary : Color.clear)
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

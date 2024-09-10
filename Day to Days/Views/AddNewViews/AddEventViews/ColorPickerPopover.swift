//
//  ColorPickerPopover.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct ColorPickerPopover: View {
    @Binding var popoverIsPresented: Bool
    @Binding var color: Color

    var body: some View {
        HStack(content: {
            Text("Color")
            Spacer()
            Button(action: {
                popoverIsPresented.toggle()
            }, label: {
                Text(color.description.capitalized)
                Image(systemName: "pencil.tip.crop.circle.fill")
            })
            .foregroundStyle(color)
            .popover(isPresented: $popoverIsPresented, content: {
                VStack {
                    VStack(alignment: .trailing, content: {
                        ForEach(Constants.AllowedColor.allCases, id: \.self) { currentColor in
                            let isSelected = color == currentColor.setColor
                            Button(action: {
                                color = currentColor.setColor
                                popoverIsPresented = false
                            }, label: {
                                HStack(alignment: .center) {
                                    Group {
                                        Text(currentColor.rawValue)
                                        Image(systemName: "pencil.tip.crop.circle.fill")
                                    }
                                    .foregroundStyle(currentColor.setColor)
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

//
//  CalorCalculator.swift
//  Day to Days
//
//  Created by mix on 06.09.2024.
//

import SwiftUI

final class ColorCalculator {
    static func oppositeToTheColorScheme(colorScheme: ColorScheme) -> Color {
        let color: Color = colorScheme == .light ? .black : .white
        return color
    }
    // TODO: Try to do something with that
    static func makeVisibleIfNot(firstColor: Color, secondColor: Color) -> Color {
        let difrentColor = firstColor == secondColor ? secondColor.inverted(): secondColor
        return difrentColor
    }
}

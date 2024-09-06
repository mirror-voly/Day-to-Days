//
//  Color+Invert.swift
//  Day to Days
//
//  Created by mix on 06.09.2024.
//

import SwiftUI

extension Color {
    func inverted() -> Color {
        let components = UIColor(self).cgColor.components ?? [0, 0, 0, 1]
        let invertedColor = Color(
            red: 1 - components[0],
            green: 1 - components[1],
            blue: 1 - components[2],
            opacity: components[3]
        )
        return invertedColor
    }
}

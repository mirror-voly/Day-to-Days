//
//  Color+Hex.swift
//  Day to Days
//
//  Created by mix on 10.09.2024.
//
//
import SwiftUI

extension Color {
    var getColorType: ColorType {
        switch self {
        case Color.gray:
            return .gray
        case Color.red:
            return .red
        case Color.green:
            return .green
        case Color.blue:
            return .blue
        case Color.yellow:
            return .yellow
        case Color.orange:
            return .orange
        case Color.pink:
            return .pink
        case Color.purple:
            return .purple
        case Color.brown:
            return .brown
        case Color.cyan:
            return .cyan
        case Color.indigo:
            return .indigo
        case Color.mint:
            return .mint
        case Color.teal:
            return .teal
        default:
            return .gray
        }
    }
}

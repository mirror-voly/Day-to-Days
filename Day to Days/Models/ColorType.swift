//
//  ColorType.swift
//  Day to Days
//
//  Created by mix on 10.09.2024.
//

import SwiftUI

enum ColorType: String, CaseIterable, Codable {
    case red = "Red"
    case orange = "Orange"
    case yellow = "Yellow"
    case green = "Green"
    case cyan = "Cyan"
    case blue = "Blue"
    case purple = "Purple"
    case pink = "Pink"
    case brown = "Brown"
    case mint = "Mint"
    case teal = "Teal"
    case indigo = "Indigo"
    case gray = "Gray"

    var getColor: Color {
        switch self {
        case .gray:
            return .gray
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        case .yellow:
            return .yellow
        case .orange:
            return .orange
        case .pink:
            return .pink
        case .purple:
            return .purple
        case .brown:
            return .brown
        case .cyan:
            return .cyan
        case .indigo:
            return .indigo
        case .mint:
            return .mint
        case .teal:
            return .teal
        }
    }
}

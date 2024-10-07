//
//  ColorType.swift
//  Day to Days
//
//  Created by mix on 10.09.2024.
//

import SwiftUI

enum ColorType: String, CaseIterable, Codable {
    case gray = "color_gray"
    case red = "color_red"
    case orange = "color_orange"
    case yellow = "color_yellow"
    case green = "color_green"
    case cyan = "color_cyan"
    case blue = "color_blue"
    case purple = "color_purple"
    case pink = "color_pink"
    case brown = "color_brown"
    case mint = "color_mint"
    case teal = "color_teal"
    case indigo = "color_indigo"

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

    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }

    static func fromData(_ data: Data) -> ColorType? {
        return try? JSONDecoder().decode(ColorType.self, from: data)
    }
}

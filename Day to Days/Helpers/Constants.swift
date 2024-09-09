//
//  Constants.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI
struct Constants {
    // TODO: - Add localisation strings
    enum Сonstraints {
        static let buttonSpaсerMinimize: CGFloat = 50
        static let buttonSpaсerMaximize: CGFloat = 130
        static let sliderCircleSizeNornmal: CGFloat = 15
        static let sliderCircleSizeMaximazed: CGFloat = 30
        static let sliderTextPadding: CGFloat = 7
        static let eventInfoButtonSize: CGFloat = 35
        static let eventDateTableSize: CGFloat = 100
    }

    enum AllowedColor: String, CaseIterable {
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

        var setColor: Color {
            switch self {
            case .gray:
                return Color.gray
            case .red:
                return Color.red
            case .green:
                return Color.green
            case .blue:
                return Color.blue
            case .yellow:
                return Color.yellow
            case .orange:
                return Color.orange
            case .pink:
                return Color.pink
            case .purple:
                return Color.purple
            case .brown:
                return Color.brown
            case .cyan:
                return Color.cyan
            case .indigo:
                return Color.indigo
            case .mint:
                return Color.mint
            case .teal:
                return Color.teal
            }
        }
    }

    static let fixedDate = Date()
}

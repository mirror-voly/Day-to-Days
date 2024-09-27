//
//  ButtonSpacerType.swift
//  Day to Days
//
//  Created by mix on 19.09.2024.
//

enum ButtonSpacerType {
    case minimize
    case maximize
    var value: Double {
        switch self {
        case .minimize:
            return Constraints.buttonSpaсerMinimize
        case .maximize:
            return Constraints.buttonSpaсerMaximize
        }
    }
}

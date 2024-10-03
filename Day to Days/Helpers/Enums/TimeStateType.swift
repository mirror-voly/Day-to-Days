//
//  TimeStateType.swift
//  Day to Days
//
//  Created by mix on 12.09.2024.
//

import Foundation

enum TimeStateType {
    case past
    case future
    case present

    var label: String {
        switch self {
        case .past: return "passed".localized
        case .future: return "left".localized
        case .present: return "today".localized
        }
    }
}

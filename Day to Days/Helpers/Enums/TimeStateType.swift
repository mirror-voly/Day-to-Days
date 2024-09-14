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
        case .past: return NSLocalizedString("passed", comment: "")
        case .future: return NSLocalizedString("left", comment: "")
        case .present: return NSLocalizedString("today", comment: "")
        }
    }
}

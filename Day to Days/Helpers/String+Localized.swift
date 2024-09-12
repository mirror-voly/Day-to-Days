//
//  String+Localized.swift
//  Day to Days
//
//  Created by mix on 12.09.2024.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

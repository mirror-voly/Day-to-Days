//
//  View+HideKeyboard.swift
//  Day to Days
//
//  Created by mix on 04.09.2024.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//
//  Publishers + KeyboardIsActive.swift
//  Day to Days
//
//  Created by mix on 06.09.2024.
//

import Combine
import UIKit

extension Publishers {
    static var keyboardWillShow: AnyPublisher<Void, Never> {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { _ in }
            .eraseToAnyPublisher()
    }

    static var keyboardWillHide: AnyPublisher<Void, Never> {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}

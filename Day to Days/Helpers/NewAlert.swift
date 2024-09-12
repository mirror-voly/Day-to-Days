//
//  NewAlert.swift
//  Day to Days
//
//  Created by mix on 07.09.2024.
//

import SwiftUI

struct NewAlert {

    static func showAlert(onConfirm: @escaping () -> Void, onCancel: @escaping () -> Void) -> Alert {
            Alert(
                title: Text("event_not_saved_title".localized),
                message: Text("event_not_saved_message".localized),
                primaryButton: .destructive(Text("yes".localized), action: onConfirm),
                secondaryButton: .default(Text("cancel".localized), action: onCancel)
            )
        }
}

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
                title: Text("Event is not saved"),
                message: Text("Are you sure that you want to erase it?"),
                primaryButton: .destructive(Text("Yes"), action: onConfirm),
                secondaryButton: .default(Text("Cancel"), action: onCancel)
            )
        }
}

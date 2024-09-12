//
//  AddEventButton.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct AddEventButton: View {
    var onAddNew: () -> Void
    @Binding var addButtonIsVisible: Bool

    var body: some View {
        VStack(content: {
            Button(action: {
                onAddNew()
            }, label: {
                Text("done".localized)
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .frame(height: Constants.Сonstraints.buttonSpaсerMinimize)
            })
            .disabled(!addButtonIsVisible)
            .contextMenu {
                if !addButtonIsVisible {
                    HelpContextMenu(helpText: "add_button_help")
                }
            }
            .buttonStyle(BorderedProminentButtonStyle())
            Spacer()
        })
    }
}

//
//  AddEventButton.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct AddEventButton: View {
    @Environment(AddOrEditEventSheetViewModel.self) private var viewModel
    var onAddNew: () -> Void

    var body: some View {
        VStack(content: {
            Button(action: {
                onAddNew()
            }, label: {
                Text("done".localized)
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .frame(height: Constraints.addButtonsize)
            })
            .disabled(!viewModel.addButtonIsVisible)
            .contextMenu {
                if !viewModel.addButtonIsVisible {
                    HelpContextMenu(helpText: "add_button_help")
                }
            }
            .buttonStyle(BorderedProminentButtonStyle())
            Spacer()
        })
    }
}

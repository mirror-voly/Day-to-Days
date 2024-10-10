//
//  HeaderView.swift
//  Day to Days
//
//  Created by mix on 10.10.2024.
//

import SwiftUI

struct HeaderView: View {
    @Environment(AddOrEditEventSheetViewModel.self) private var viewModel
    @Environment(AlertManager.self) private var alertManager
    @Binding var isOpened: Bool

    var body: some View {
        HStack {
            Text(viewModel.sheetTitle)
            Spacer()
            Button(action: {
                viewModel.buttonAction(completion: { result in
                    alertManager.getIdentifiebleErrorFrom(result: result)
                })
                isOpened = false
            }, label: {
                Text("done".localized)
            })
            .disabled(!viewModel.addButtonIsVisible)
            .opacity(viewModel.addButtonIsVisible ? Constraints.originalSize :
                        Constraints.scaleColorItem)
            .tint(viewModel.color)
            .buttonStyle(BorderedButtonStyle())
            .foregroundStyle(.primary)
            .contextMenu {
                if !viewModel.addButtonIsVisible {
                    HelpContextMenu(helpText: "add_button_help")
                }
            }
        }
    }
}

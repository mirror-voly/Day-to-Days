//
//  NotificationSetupHeader.swift
//  Day to Days
//
//  Created by mix on 16.10.2024.
//

import SwiftUI

struct NotificationSetupHeader: View {
	@Environment(NotificationSettingsViewModel.self) private var viewModel
	@Environment(AlertManager.self) var alertManager
	@Environment(\.dismiss) private var dismiss
    var body: some View {
		HStack {
			Group {
				Button("remove".localized) {
					viewModel.removeButtonAction()
				}
				.disabled(viewModel.removeButtonIsDisabled)
				Spacer()
				Button("done".localized) {
					viewModel.doneButtonAction(completion: { result in
						alertManager.getIdentifiebleErrorFrom(result: result)
					})
					dismiss()
				}
				.disabled(viewModel.doneButtonIsDisabled)
				.contextMenu {
					if viewModel.doneButtonIsDisabled {
						HelpContextMenu(helpText: "notification_done_button_help")
					}
				}
			}
			.buttonStyle(.borderedProminent)
		}
    }
}

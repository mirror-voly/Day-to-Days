//
//  NotificationSetupView.swift
//  Day to Days
//
//  Created by mix on 11.10.2024.
//

import SwiftUI

struct NotificationSetupView: View {
    @State var viewModel: NotificationSettingsViewModel

    var body: some View {
        VStack {
			NotificationSetupHeader()

            GroupBox {
				NotificationSetupDateTypeSelector()
                Divider()
				NotificationSetupDatePickerSwitch(viewModel: viewModel)
                Divider()
                Toggle("show_all_information".localized, isOn: $viewModel.toggleDetailedValue)
            }

            Spacer()
        }
        .padding()
		.environment(viewModel)
    }

    init(event: Event, notificationManager: NotificationManager) {
		self.viewModel = NotificationSettingsViewModel(event: event, notificationManager: notificationManager)
    }
}

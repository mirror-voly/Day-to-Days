//
//  NotificationSetupDateTypeSelector.swift
//  Day to Days
//
//  Created by mix on 16.10.2024.
//

import SwiftUI

struct NotificationSetupDateTypeSelector: View {
	@Environment(NotificationSettingsViewModel.self) private var viewModel
    var body: some View {
		HStack(content: {
			Text("show_notifications_every".localized)
			Spacer()
			Menu(String(describing: viewModel.dateType).localized, content: {
				ForEach(DateType.allCases, id: \.self) { type in
					Button(String(describing: type).localized,
						   systemImage: viewModel.dateType == type ?
						   "smallcircle.filled.circle" : "circle") {
						viewModel.dateType = type
					}
				}
			})
			.buttonStyle(.bordered)
			.tint(.secondary)
			.foregroundStyle(.primary)
		})
    }
}

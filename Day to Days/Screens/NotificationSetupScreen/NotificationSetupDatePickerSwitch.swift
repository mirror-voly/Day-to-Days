//
//  NotificationSetupDatePickerSwitch.swift
//  Day to Days
//
//  Created by mix on 16.10.2024.
//

import SwiftUI

struct NotificationSetupDatePickerSwitch: View {
	@Bindable var viewModel: NotificationSettingsViewModel
    var body: some View {
		switch viewModel.dateType {
		case .day:
			DatePicker("time".localized, selection: $viewModel.date, displayedComponents: .hourAndMinute)
		case .week:
			HStack {
				Text("day_of_week".localized)
				Spacer()
				Menu((String(describing: viewModel.dayOfWeek).localized), content: {
					ForEach(DayOfWeek.allCases, id: \.self) { type in
						Button(String(describing: type).localized,
							   systemImage: viewModel.dayOfWeek == type ?
							   "smallcircle.filled.circle" : "circle") {
							viewModel.dayOfWeek = type
						}
					}
				})
				.buttonStyle(.bordered)
				.tint(.secondary)
				.foregroundStyle(.primary)
				DatePicker("", selection: $viewModel.date, displayedComponents: .hourAndMinute)
					.frame(width: Constraints.notificationDateWidth)
			}
		case .month:
			DatePicker("day_of_month".localized, selection: $viewModel.date)
				.datePickerStyle(.compact)
		case .year:
			DatePicker("day_of_year".localized, selection: $viewModel.date)
				.datePickerStyle(.compact)
		}
    }
}

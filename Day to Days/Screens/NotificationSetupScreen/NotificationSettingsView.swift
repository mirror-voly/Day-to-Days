//
//  NotificationSettingsView.swift
//  Day to Days
//
//  Created by mix on 11.10.2024.
//

import SwiftUI

struct NotificationSettingsView: View {
    @State var viewModel: NotificationSettingsViewModel
    @Environment(AlertManager.self) var alertManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
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
            GroupBox {
                HStack(content: {
                    Text("show_notifications_every".localized)
                    Spacer()
                    Menu(String(describing: viewModel.dateType).localized, content: {
                        ForEach(DateType.allCases, id: \.self) { type in
                            Button(String(describing: type).localized,
                                   systemImage: viewModel.dateType == type ? "smallcircle.filled.circle" : "circle") {
                                viewModel.dateType = type
                            }
                        }
                    })
                    .buttonStyle(.bordered)
                    .tint(.secondary)
                    .foregroundStyle(.primary)
                })
                Divider()
                switch viewModel.dateType {
                case .day:
                    DatePicker("time".localized, selection: $viewModel.date, displayedComponents: .hourAndMinute)
                case .week:
                    HStack {
                        Text("day_of_week".localized)
                        Spacer()
                        Menu((String(describing: viewModel.dayOfWeak).localized), content: {
                            ForEach(DayOfWeek.allCases, id: \.self) { type in
                                Button(String(describing: type).localized,
                                       systemImage: viewModel.dayOfWeak == type ? "smallcircle.filled.circle" : "circle") {
                                    viewModel.dayOfWeak = type
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
            Spacer()
        }
        .padding()
    }
    init(event: Event) {
        self.viewModel = NotificationSettingsViewModel(event: event)
    }
}

#Preview {
    NotificationSettingsView(event: Event())
}

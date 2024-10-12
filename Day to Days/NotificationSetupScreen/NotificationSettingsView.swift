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
                    Button("Remove") {
                        viewModel.removeButtonAction()
                    }
                    .disabled(viewModel.removeButtonIsDisabled)
                    Spacer()
                    Button("done".localized) {
                        viewModel.doneButtonAction()
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
                    Text("Show notifications every")
                    Spacer()
                    Menu(String(describing: viewModel.dateType).capitalized, content: {
                        ForEach(DateType.allCases, id: \.self) { type in
                            Button(String(describing: type).capitalized,
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
                    DatePicker("Time", selection: $viewModel.date, displayedComponents: .hourAndMinute)
                case .week:
                    HStack {
                        Text("Day of week")
                        Spacer()
                        Menu((String(describing: viewModel.dayOfWeak).capitalized), content: {
                            ForEach(DayOfWeek.allCases, id: \.self) { type in
                                Button(String(describing: type).capitalized,
                                       systemImage: viewModel.dayOfWeak == type ? "smallcircle.filled.circle" : "circle") {
                                    viewModel.dayOfWeak = type
                                }
                            }
                        })
                        .buttonStyle(.bordered)
                        .tint(.secondary)
                        .foregroundStyle(.primary)
                        DatePicker("", selection: $viewModel.date, displayedComponents: .hourAndMinute)
                            .frame(width: 80)
                    }
                case .month:
                    DatePicker("Day of month", selection: $viewModel.date)
                        .datePickerStyle(.compact)
                case .year:
                    DatePicker("Day of year", selection: $viewModel.date)
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

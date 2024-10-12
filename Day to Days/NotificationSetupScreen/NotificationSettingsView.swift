//
//  NotificationSettingsView.swift
//  Day to Days
//
//  Created by mix on 11.10.2024.
//

import SwiftUI

struct NotificationSettingsView: View {

    enum DayOfWeek: CaseIterable {
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
    }

    let event: Event
    @State var date = Date()
    @State var dateType: DateType = .day
    @State var dayOfWeak: DayOfWeek = .monday
    @State var menuItemsIsPresented = false
    @State var doneButtonIsDisabled = true
    @Environment(AlertManager.self) var alertManager
    let notificationManager = NotificationManager()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("done".localized) {
//                    notificationManager.sheduleNotification()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .disabled(doneButtonIsDisabled)
                .onAppear(perform: {
                    notificationManager.requestPermitions {
                        doneButtonIsDisabled = false
                    }
                })
                .contextMenu {
                    if doneButtonIsDisabled {
                        HelpContextMenu(helpText: "notification_done_button_help")
                    }
                }
            }
            GroupBox {
                HStack(content: {
                    Text("Show notification every")
                    Spacer()
                    Menu(String(describing: dateType).capitalized, content: {
                        ForEach(DateType.allCases, id: \.self) { type in
                            Button(String(describing: type).capitalized) {
                                dateType = type
                            }
                        }
                    })
                })
                Divider()
                switch dateType {
                case .day:
                    DatePicker("Time", selection: $date, displayedComponents: .hourAndMinute)
                case .week:
                    HStack {
                        Text("Day of week")
                        Spacer()
                        Menu((String(describing: dayOfWeak).capitalized), content: {
                            ForEach(DayOfWeek.allCases, id: \.self) { type in
                                Button(String(describing: type).capitalized) {
                                    dayOfWeak = type
                                }
                            }
                        })
                        DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                            .frame(width: 80)
                    }
                case .month:
                    DatePicker("Day of month", selection: $date)
                        .datePickerStyle(.compact)
                case .year:
                    DatePicker("Day of year", selection: $date)
                        .datePickerStyle(.compact)
                }
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    NotificationSettingsView(event: Event())
}

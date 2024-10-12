//
//  NotificationSettingsViewModel.swift
//  Day to Days
//
//  Created by mix on 12.10.2024.
//

import Foundation
@Observable
final class NotificationSettingsViewModel {
    let notificationManager = NotificationManager()
    let event: Event
    var date = Date()
    var dateType: DateType = .day
    var dayOfWeak: DayOfWeek = .monday
    var menuItemsIsPresented = false
    private (set) var doneButtonIsDisabled = true
    private (set) var removeButtonIsDisabled = true

    func isRemoveButtonIsDisabled() {
        notificationManager.checkIfNotificationIsScheduled(with: event.id.uuidString) { result in
            self.removeButtonIsDisabled = !result
        }
    }

    func removeButtonAction() {
        notificationManager.removeScheduledNotification(with: event.id.uuidString)
        isRemoveButtonIsDisabled()
    }

    func doneButtonAction() {
        switch dateType {
        case .day:
            notificationManager.scheduleDaylyNotification(for: date, event: event)
        case .week:
            notificationManager.scheduleWeeklyNotification(for: date, event: event, weekDay: dayOfWeak)
        case .month:
            notificationManager.scheduleMonthlyNotification(on: date, event: event)
        case .year:
            notificationManager.scheduleYearlyNotification(on: date, event: event)
        }

    }

    init(event: Event) {
        self.event = event
        notificationManager.requestPermitions {
            self.doneButtonIsDisabled = false
        }
        isRemoveButtonIsDisabled()
        //        self.dayOfWeak = dayOfWeak
    }
}

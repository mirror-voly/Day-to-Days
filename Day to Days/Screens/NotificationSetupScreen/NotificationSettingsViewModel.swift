//
//  NotificationSettingsViewModel.swift
//  Day to Days
//
//  Created by mix on 12.10.2024.
//

import Foundation
@Observable
final class NotificationSettingsViewModel {
	let notificationManager: NotificationManager
    let event: Event
    var date = Date()
    var dateType: DateType = .day
    var dayOfWeek: DayOfWeek = .monday
    var menuItemsIsPresented = false
    var toggleDetailedValue = true
    private (set) var doneButtonIsDisabled = true
    private (set) var removeButtonIsDisabled = true

    func checkIsAbleToRemove() {
		notificationManager.checkIfNotificationIsScheduled(with: event.id.uuidString) { result in
            self.removeButtonIsDisabled = !result
        }
    }

    func removeButtonAction() {
		notificationManager.removeScheduledNotification(eventStringID: event.id.uuidString)
        checkIsAbleToRemove()
    }

    func doneButtonAction(completion: @escaping (Result<Void, Error>) -> Void) {
		notificationManager.scheduleNotification(dateType: dateType,
                                                 date: date,
                                                 event: event,
                                                 dayOfWeek: dateType == .week ? dayOfWeek : nil,
                                                 detailed: toggleDetailedValue,
                                                 completion: { result in
            completion(result)
        })

    }

    init(event: Event, notificationManager: NotificationManager) {
        self.event = event
		self.notificationManager = notificationManager
		notificationManager.requestPermitions {
            self.doneButtonIsDisabled = false
        }
        checkIsAbleToRemove()
        dayOfWeek = DateCalculator.getCurrentDayOfWeek(date: Date())
    }
}

//
//  NotificationSettingsViewModel.swift
//  Day to Days
//
//  Created by mix on 12.10.2024.
//

import Foundation
@Observable
final class NotificationSettingsViewModel {
    let event: Event
    var date = Date()
    var dateType: DateType = .day
    var dayOfWeek: DayOfWeek = .monday
    var menuItemsIsPresented = false
    var toggleDetailedValue = true
    private (set) var doneButtonIsDisabled = true
    private (set) var removeButtonIsDisabled = true

    func isRemoveButtonIsDisabled() {
        NotificationManager.checkIfNotificationIsScheduled(with: event.id.uuidString) { result in
            self.removeButtonIsDisabled = !result
        }
    }

    func removeButtonAction() {
        NotificationManager.removeScheduledNotification(eventStringID: event.id.uuidString)
        isRemoveButtonIsDisabled()
    }

    func doneButtonAction(completion: @escaping (Result<Void, Error>) -> Void) {
        NotificationManager.scheduleNotification(dateType: dateType,
                                                 date: date,
                                                 event: event,
                                                 dayOfWeek: dateType == .week ? dayOfWeek : nil,
                                                 detailed: toggleDetailedValue,
                                                 completion: { result in
            completion(result)
        })

    }

    init(event: Event) {
        self.event = event
        NotificationManager.requestPermitions {
            self.doneButtonIsDisabled = false
        }
        isRemoveButtonIsDisabled()
        dayOfWeek = DateCalculator.getCurrentDayOfWeek(date: Date())
    }
}

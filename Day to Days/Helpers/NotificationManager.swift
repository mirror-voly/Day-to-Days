//
//  NotificationManager.swift
//  Day to Days
//
//  Created by mix on 11.10.2024.
//

import Foundation
import NotificationCenter

final class NotificationManager {
    let calendar = Calendar.current
    private let dateCalculator = DateCalculator()

    func requestPermitions(complition: @escaping () -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
            if success { complition() }
        }
    }

    func removeAllScheduledNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func removeScheduledNotification(with identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }

    func checkIfNotificationIsScheduled(with identifier: String, completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            let isScheduled = requests.contains { $0.identifier == identifier }
            completion(isScheduled)
        }
    }

    private func makeTimeDataString(date: Date, dateType: DateType) -> String {
        let timeData = dateCalculator.allTimeDataFor(date: date, dateType: dateType)
        let localizedTimeState = timeData[.localizedTimeState]?.capitalized ?? Constants.emptyString
        let number = timeData[.dateNumber] ?? Constants.emptyString
        let localizedDateType = (timeData[.timeState] != TimeStateType.present.label ?
                                  timeData[.localizedDateType]: Constants.emptyString) ?? Constants.emptyString
        return "\(localizedTimeState) \(number) \(localizedDateType)"
    }

    private func makeContent(event: Event) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = event.title
        content.subtitle = makeTimeDataString(date: event.date, dateType: event.dateType)
        content.sound = .default
        return content
    }

    func scheduleDaylyNotification(for date: Date, event: Event) {
        let content = makeContent(event: event)
        let components = calendar.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: event.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
    }

    func scheduleWeeklyNotification(for date: Date, event: Event, weekDay: DayOfWeek) {
        let content = makeContent(event: event)
        var components = calendar.dateComponents([.hour, .minute], from: date)
        components.weekday = weekDay.rawValue

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: event.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
    }

    func scheduleMonthlyNotification(on date: Date, event: Event) {
        let content = makeContent(event: event)
        var components = calendar.dateComponents([.month, .hour, .minute], from: date)
        components.day = calendar.component(.day, from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: event.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
    }

    func scheduleYearlyNotification(on date: Date, event: Event) {
        let content = makeContent(event: event)
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        components.year = nil
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: event.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
    }
}

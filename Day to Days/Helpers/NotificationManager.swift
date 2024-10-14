//
//  NotificationManager.swift
//  Day to Days
//
//  Created by mix on 11.10.2024.
//

import Foundation
import NotificationCenter

final class NotificationManager {
    
    static func requestPermitions(complition: @escaping () -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
            if success { complition() }
        }
    }

    //    func removeAllScheduledNotifications() {
    //        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    //    }

    static func removeScheduledNotification(eventStringID: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [eventStringID])
        guard let userDefaults = UserDefaults(suiteName: Constants.suiteName) else { return }
        userDefaults.removeObject(forKey: eventStringID)
    }

    private static func encodeAndSaveNotificationSettings(eventID: String,
                                   notificationSettings: NotificationSettings,
                                   completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let data = try JSONEncoder().encode(notificationSettings)
            if let userDefaults = UserDefaults(suiteName: Constants.suiteName) {
                userDefaults.set(data, forKey: eventID)
            }
        } catch {
            completion(.failure(error))
        }
    }

    private static func decodeData(data: Data, completion: @escaping (Result<Void, Error>) -> Void) -> NotificationSettings? {
        do {
            let decoded = try JSONDecoder().decode(NotificationSettings.self, from: data)
            completion(.success(()))
            return decoded
        } catch {
            completion(.failure(error))
            return nil
        }
    }

    static func updateNotificatioIfNeeded(event: Event,
                                          completion: @escaping (Result<Void, Error>) -> Void) {
        checkIfNotificationIsScheduled(with: event.id.uuidString) { scheduled in
            if scheduled {
                guard let userDefaults = UserDefaults(suiteName: Constants.suiteName) else { return }
                guard let data = userDefaults.data(forKey: event.id.uuidString) else { return }
                guard let decoded = decodeData(data: data, completion: { result in
                    completion(result)
                }) else { return }
                scheduleNotification(dateType: decoded.dateType, date: decoded.date, event: event, dayOfWeek: DateCalculator.getCurrentDayOfWeek(date: decoded.date), completion: { result in
                    completion(result)
                })
            }
        }
    }

    static func checkIfNotificationIsScheduled(with identifier: String, completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            let isScheduled = requests.contains { $0.identifier == identifier }
            completion(isScheduled)
        }
    }

    private static func makeTimeDataString(date: Date, dateType: DateType) -> String {
        let dateCalculator = DateCalculator()
        let timeData = dateCalculator.allTimeDataFor(date: date, dateType: dateType)
        let localizedTimeState = timeData[.localizedTimeState]?.capitalized ?? Constants.emptyString
        let number = timeData[.dateNumber] ?? Constants.emptyString
        let localizedDateType = (timeData[.timeState] != TimeStateType.present.label ?
                                  timeData[.localizedDateType]: Constants.emptyString) ?? Constants.emptyString
        return "\(localizedTimeState) \(number) \(localizedDateType)"
    }

    private static func makeContent(event: Event) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = event.title
        content.subtitle = event.id.uuidString /*makeTimeDataString(date: event.date, dateType: event.dateType)*/
        content.sound = .default
        content.categoryIdentifier = "myNotificationCategory"
        return content
    }

    private static func scheduleDaylyNotification(for date: Date,
                                                  event: Event,
                                                  completion: @escaping (Result<Void, Error>) -> Void) {
        let calendar = Calendar.current
        let content = makeContent(event: event)
        let components = calendar.dateComponents([.hour, .minute], from: date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: event.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                completion(.failure(error))
            }
        }
    }

    private static func scheduleWeeklyNotification(for date: Date,
                                                   event: Event,
                                                   dayOfWeek: DayOfWeek,
                                                   completion: @escaping (Result<Void, Error>) -> Void) {
        let calendar = Calendar.current
        let content = makeContent(event: event)
        var components = calendar.dateComponents([.hour, .minute], from: date)
        components.weekday = dayOfWeek.rawValue

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: event.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                completion(.failure(error))
            }
        }
    }

    private static func scheduleMonthlyNotification(on date: Date,
                                                    event: Event,
                                                    completion: @escaping (Result<Void, Error>) -> Void) {
        let calendar = Calendar.current
        let content = makeContent(event: event)
        var components = calendar.dateComponents([.month, .hour, .minute], from: date)
        components.day = calendar.component(.day, from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: event.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                completion(.failure(error))
            }
        }
    }

    private static func scheduleYearlyNotification(on date: Date,
                                                   event: Event,
                                                   completion: @escaping (Result<Void, Error>) -> Void) {
        let calendar = Calendar.current
        let content = makeContent(event: event)
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        components.year = nil
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: event.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                completion(.failure(error))
            }
        }
    }

    static func scheduleNotification(dateType: DateType,
                                     date: Date,
                                     event: Event,
                                     dayOfWeek: DayOfWeek?,
                                     completion: @escaping (Result<Void, Error>) -> Void) {
        let scheduleCompletion: (Result<Void, Error>) -> Void = { result in
            completion(result)
        }
        
        switch dateType {
        case .day:
            scheduleDaylyNotification(for: date, event: event, completion: scheduleCompletion)
        case .week:
            guard let dayOfWeek = dayOfWeek else { return }
            scheduleWeeklyNotification(for: date, event: event, dayOfWeek: dayOfWeek, completion: scheduleCompletion)
        case .month:
            scheduleMonthlyNotification(on: date, event: event, completion: scheduleCompletion)
        case .year:
            scheduleYearlyNotification(on: date, event: event, completion: scheduleCompletion)
        }
        
        encodeAndSaveNotificationSettings(eventID: event.id.uuidString,
                                          notificationSettings: NotificationSettings(dateType: dateType, date: date),
                                          completion: scheduleCompletion)
    }

}

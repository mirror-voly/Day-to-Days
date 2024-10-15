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

	static func removeScheduledNotification(eventStringID: String) {
		UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [eventStringID])
		guard let userDefaults = UserDefaults(suiteName: Constants.suiteName) else { return }
		userDefaults.removeObject(forKey: eventStringID)
	}

    private static func encodeAndSaveNotificationSettings(eventID: String,
                                   notificationSettings: NotificationSettings,
                                   completion: @escaping (Result<Void, Error>) -> Void) {
		DispatchQueue.global(qos: .utility).async {
			do {
				let data = try JSONEncoder().encode(notificationSettings)
				if let userDefaults = UserDefaults(suiteName: Constants.suiteName) {
					userDefaults.set(data, forKey: eventID)
				}
			} catch {
				completion(.failure(error))
			}
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
		DispatchQueue.global(qos: .utility).async {
			checkIfNotificationIsScheduled(with: event.id.uuidString) { scheduled in
				if scheduled {
					guard let userDefaults = UserDefaults(suiteName: Constants.suiteName) else { return }
					guard let data = userDefaults.data(forKey: event.id.uuidString) else { return }
					guard let decoded = decodeData(data: data, completion: { result in
						completion(result)
					}) else { return }
					scheduleNotification(dateType: decoded.dateType,
										 date: decoded.date,
										 event: event, dayOfWeek: DateCalculator.getCurrentDayOfWeek(date: decoded.date),
										 detailed: decoded.detailed, completion: { result in
						completion(result)
					})
				}
			}
		}
	}

    static func checkIfNotificationIsScheduled(with identifier: String, completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            let isScheduled = requests.contains { $0.identifier == identifier }
            completion(isScheduled)
        }
    }

    private static func makeContent(event: Event, detailed: Bool) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = event.title
        content.subtitle = "open_for_details".localized
        content.sound = .default
        content.categoryIdentifier = detailed ? "maximizedNotificationCategory" : "minimalisticNotificationCategory"
        return content
    }

    private static func scheduleDaylyNotification(for date: Date,
                                                  event: Event,
                                                  detailed: Bool,
                                                  completion: @escaping (Result<Void, Error>) -> Void) {
        let calendar = Calendar.current
        let content = makeContent(event: event, detailed: detailed)
        let components = calendar.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
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
                                                   detailed: Bool,
                                                   completion: @escaping (Result<Void, Error>) -> Void) {
        let calendar = Calendar.current
        let content = makeContent(event: event, detailed: detailed)
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
                                                    detailed: Bool,
                                                    completion: @escaping (Result<Void, Error>) -> Void) {
        let calendar = Calendar.current
        let content = makeContent(event: event, detailed: detailed)
        let components = calendar.dateComponents([.day, .hour, .minute], from: date)
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
                                                   detailed: Bool,
                                                   completion: @escaping (Result<Void, Error>) -> Void) {
        let calendar = Calendar.current
        let content = makeContent(event: event, detailed: detailed)
        let components = calendar.dateComponents([.month, .day, .hour, .minute], from: date)
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
                                     detailed: Bool,
									 completion: @escaping (Result<Void, Error>) -> Void) {
		DispatchQueue.global(qos: .utility).async {
			let scheduleCompletion: (Result<Void, Error>) -> Void = { result in
				completion(result)
			}
			
			switch dateType {
				case .day:
					scheduleDaylyNotification(for: date, event: event, detailed: detailed, completion: scheduleCompletion)
				case .week:
					guard let dayOfWeek = dayOfWeek else { return }
					scheduleWeeklyNotification(for: date, event: event, dayOfWeek: dayOfWeek,
											   detailed: detailed, completion: scheduleCompletion)
				case .month:
					scheduleMonthlyNotification(on: date, event: event, detailed: detailed, completion: scheduleCompletion)
				case .year:
					scheduleYearlyNotification(on: date, event: event, detailed: detailed, completion: scheduleCompletion)
			}
			
			encodeAndSaveNotificationSettings(eventID: event.id.uuidString,
											  notificationSettings: NotificationSettings(dateType: dateType,
																						 date: date,
																						 detailed: detailed),
											  completion: scheduleCompletion)
		}
	}
}

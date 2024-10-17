//
//  NotificationDelegate.swift
//  Day to Days
//
//  Created by mix on 17.10.2024.
//

import Foundation
import UserNotifications

final class NotificationDelegate: NSObject {
	private weak var viewModel: MainScreenViewModel?
	private let notificationCenter = UNUserNotificationCenter.current()
	
	func setViewModel(_ viewModel: MainScreenViewModel) {
		self.viewModel = viewModel
	}
	
	override init() {
		super.init()
		notificationCenter.delegate = self
	}
}

extension NotificationDelegate: UNUserNotificationCenterDelegate  {
	
	func userNotificationCenter(_ center: UNUserNotificationCenter, 
								didReceive response: UNNotificationResponse, 
								withCompletionHandler completionHandler: @escaping () -> Void) {

		let userInfo = response.notification.request.content.userInfo
		if let deepLink = userInfo[Constants.deepLink] as? String {
			let eventID = UUID(uuidString: deepLink)
			if let event = viewModel?.sortedEvents.first(where: {$0.id == eventID }) {
				viewModel?.path.append(event)
			}
		}
		completionHandler()
	}
}

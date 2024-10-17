//
//  NotificationViewController.swift
//  NotificationExtention
//
//  Created by mix on 13.10.2024.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController {
	let searchTransferEvent = LoadTransferEvent()
    let dateCalculator = DateCalculator()
    @IBOutlet var labelFirst: UILabel?
    @IBOutlet var labelSecond: UILabel?
    @IBOutlet var labelThird: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
    }

    private func setupLabels() {
        labelSecond?.font = .boldSystemFont(ofSize: Constraints.notificationBigFontSize)
        labelSecond?.clipsToBounds = false
        labelThird?.textColor = .gray
        labelThird?.font = .italicSystemFont(ofSize: Constraints.notificationSmallFontSize)
    }

}

extension NotificationViewController: UNNotificationContentExtension {

    func didReceive(_ notification: UNNotification) {
		if let eventID = notification.request.content.userInfo["deepLink"] as? String {
			guard let event = searchTransferEvent.findEventByID(eventID) else { return }
			let timeData = dateCalculator.allTimeDataFor(date: event.date, dateType: event.dateType)
			self.labelFirst?.text = timeData[.localizedTimeState]?.capitalized ?? Constants.emptyString
			self.labelSecond?.text = timeData[.dateNumber] ?? Constants.emptyString
			if timeData[.timeState] != TimeStateType.present.label {
				self.labelThird?.text = timeData[.localizedDateType] ?? Constants.emptyString
			}
		}
    }
}

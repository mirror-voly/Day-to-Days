//
//  NotificationViewController.swift
//  NotificationMaximizedExtention
//
//  Created by mix on 15.10.2024.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController {
    let dateCalculator = DateCalculator()
	let searchTransferEvent = LoadTransferEvent()

    @IBOutlet var labelFirst: UILabel?
    @IBOutlet var labelSecond: UILabel?
    @IBOutlet var labelThird: UILabel?
    @IBOutlet var labelFourth: UILabel?
    @IBOutlet var labelFifth: UILabel?
    @IBOutlet var labelSixth: UILabel?
    @IBOutlet var labelSeventh: UILabel?
    @IBOutlet var labelEighth: UILabel?
    @IBOutlet var labelNinth: UILabel?
    @IBOutlet var eventTitleLabel: UILabel!
    @IBOutlet var eventDateLabel: UILabel!

    private func setUnitLabel(_ label: UILabel?, with value: String, dateType: DateType) {
        guard let label = label else { return }
        label.text = dateCalculator.localizeIt(for: value, dateType: dateType)
        label.textColor = .gray
        label.font = .italicSystemFont(ofSize: Constraints.notificationSmallFontSize)
    }

    private func setNumberLabel(_ label: UILabel?, with value: String) {
        guard let label = label else { return }
        label.text = value
        label.font = .boldSystemFont(ofSize: Constraints.notificationMediumFontSize)
    }

    private func updateLabels(for dateType: DateType, with timeData: [DateType: String]) {
		eventTitleLabel.font = .boldSystemFont(ofSize: Constraints.notificationMediumFontSize)
		eventDateLabel.textColor = .gray
		
		guard let day = timeData[.day] else { return }
        setNumberLabel(labelSecond, with: day)
        setUnitLabel(labelThird, with: day, dateType: .day)

		guard let week = timeData[.week] else { return }
        setNumberLabel(labelFourth, with: week)
        setUnitLabel(labelFifth, with: week, dateType: .week)

		guard let month = timeData[.month] else { return }
        setNumberLabel(labelSixth, with: month)
        setUnitLabel(labelSeventh, with: month, dateType: .month)

		guard let year = timeData[.year] else { return }
        setNumberLabel(labelEighth, with: year)
        setUnitLabel(labelNinth, with: year, dateType: .year)
    }
}

extension NotificationViewController: UNNotificationContentExtension {

    func didReceive(_ notification: UNNotification) {
		if let eventID = notification.request.content.userInfo["deepLink"] as? String {
			guard let event = searchTransferEvent.findEventByID(eventID) else { return }
			self.eventTitleLabel.text = event.title
			self.eventDateLabel.text = event.date.formatted(Date.FormatStyle() .year().month().day())
			self.labelFirst?.text = dateCalculator.getLocalizedTimeState(date: event.date, dateType: event.dateType).capitalized
			let timeData = dateCalculator.dateInfoForThis(date: event.date, dateType: event.dateType)
			updateLabels(for: event.dateType, with: timeData)
		}
    }
}

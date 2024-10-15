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

    private func decodeData(data: Data) -> [EventForTransfer]? {
        do {
            let decoded = try JSONDecoder().decode([EventForTransfer].self, from: data)
            return decoded
        } catch {
            return nil
        }
    }

    private func setInfo(title: String) -> EventForTransfer? {
        let userDefaults = UserDefaults(suiteName: Constants.suiteName)
        guard let data = userDefaults?.data(forKey: Constants.widgetStorage) else { return nil }
        let decoded = decodeData(data: data)
        guard let event: EventForTransfer = decoded?.first(where: {$0.title == title}) else { return nil }
        return event
    }
}

extension NotificationViewController: UNNotificationContentExtension {

    func didReceive(_ notification: UNNotification) {
        guard let event = setInfo(title: notification.request.content.title) else { return }
        let timeData = dateCalculator.allTimeDataFor(date: event.date, dateType: event.dateType)
        self.labelFirst?.text = timeData[.localizedTimeState]?.capitalized ?? Constants.emptyString
        self.labelSecond?.text = timeData[.dateNumber] ?? Constants.emptyString
        if timeData[.timeState] != String(describing: TimeStateType.present) {
            self.labelThird?.text = timeData[.localizedDateType] ?? Constants.emptyString
        }
    }
}

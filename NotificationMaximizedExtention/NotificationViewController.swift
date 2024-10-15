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
    
    @IBOutlet var labelFirst: UILabel?
    @IBOutlet var labelSecond: UILabel?
    @IBOutlet var labelThird: UILabel?
    @IBOutlet var labelFourth: UILabel?
    @IBOutlet var labelFifth: UILabel?
    @IBOutlet var labelSixth: UILabel?
    @IBOutlet var labelSeventh: UILabel?
    @IBOutlet var labelEighth: UILabel?
    @IBOutlet var labelNinth: UILabel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelFirst?.font = .systemFont(ofSize: 17)

        labelSecond?.font = .boldSystemFont(ofSize: 25)
        labelFourth?.font = .boldSystemFont(ofSize: 25)
        labelSixth?.font = .boldSystemFont(ofSize: 25)
        labelEighth?.font = .boldSystemFont(ofSize: 25)
        
        labelThird?.textColor = .gray
        labelThird?.font = .italicSystemFont(ofSize: 15)
        
        labelFifth?.textColor = .gray
        labelFifth?.font = .italicSystemFont(ofSize: 15)
        
        labelSeventh?.textColor = .gray
        labelSeventh?.font = .italicSystemFont(ofSize: 15)
        
        labelNinth?.textColor = .gray
        labelNinth?.font = .italicSystemFont(ofSize: 15)
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

    private func updateLabels(for dateType: DateType, with timeData: [DateType: String]) {
        let numberDay = timeData[.day] ?? Constants.emptyString
        self.labelSecond?.text = numberDay
        self.labelThird?.text = dateCalculator.localizeIt(for: numberDay, dateType: .day)
//        if dateType == .day {
//            return
//        }
        
        let numberWeek = timeData[.week] ?? Constants.emptyString
        print(numberWeek)
        self.labelFourth?.text = numberWeek
        self.labelFifth?.text = dateCalculator.localizeIt(for: numberWeek, dateType: .week)
//        if dateType == .week {
//            return
//        }

        let numberMonth = timeData[.month] ?? Constants.emptyString
        self.labelSixth?.text = numberMonth
        self.labelSeventh?.text = dateCalculator.localizeIt(for: numberMonth, dateType: .month)
        
//        if dateType == .month {
//            return
//        }
        
        let numberYear = timeData[.year] ?? Constants.emptyString
        self.labelEighth?.text = numberYear
        self.labelNinth?.text = dateCalculator.localizeIt(for: numberYear, dateType: .year)
    }
}

extension NotificationViewController: UNNotificationContentExtension {
    
    func didReceive(_ notification: UNNotification) {
        guard let event = setInfo(title: notification.request.content.title) else { return }
        
        self.labelFirst?.text = dateCalculator.getLocalizedTimeState(date: event.date, dateType: event.dateType).capitalized
        let timeData = dateCalculator.dateInfoForThis(date: event.date, dateType: event.dateType)
        updateLabels(for: event.dateType, with: timeData)
    }



}

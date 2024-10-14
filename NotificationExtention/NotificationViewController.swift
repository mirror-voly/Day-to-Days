//
//  NotificationViewController.swift
//  NotificationExtention
//
//  Created by mix on 13.10.2024.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet var labelFirst: UILabel?
    @IBOutlet var labelSecond: UILabel?
    @IBOutlet var labelThird: UILabel?
    //    private var data: NotificationSettings?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.labelFirst?.text = notification.request.content.title
        self.labelSecond?.text = notification.request.content.subtitle
        self.labelThird?.text = notification.request.content.subtitle
    }
    //
//    private func decodeData(data: Data, completion: @escaping (Result<Void, Error>) -> Void) -> [EventForTransfer]? {
//        do {
//            let decoded = try JSONDecoder().decode([EventForTransfer].self, from: data)
//            completion(.success(()))
//            return decoded
//        } catch {
//            completion(.failure(error))
//            return nil
//        }
//    }
//    
//    func setInfo(eventID: String, completion: @escaping (Result<Void, Error>) -> Void) -> EventForTransfer? {
//        guard let userDefaults = UserDefaults(suiteName: Constants.suiteName) else { return nil }
//        guard let data = userDefaults.data(forKey: Constants.widgetStorage) else { return nil }
//        guard let decoded = decodeData(data: data, completion: { result in
//            completion(result)
//        }) else { return nil }
//        if let event: EventForTransfer = decoded.first(where: {$0.id.uuidString == eventID}) {
//            return event
//        }
//        return nil
//    }
}

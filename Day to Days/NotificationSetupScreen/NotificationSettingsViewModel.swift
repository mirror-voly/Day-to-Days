//
//  NotificationSettingsViewModel.swift
//  Day to Days
//
//  Created by mix on 12.10.2024.
//

import Foundation
@Observable
final class NotificationSettingsViewModel{
    
    let event: Event
    var date = Date()
    var dateType: DateType = .day
    var dayOfWeak: DayOfWeek = .monday
    var menuItemsIsPresented = false
    var doneButtonIsDisabled = true
    
    let notificationManager = NotificationManager()
    
    init(event: Event) {
        self.event = event
        notificationManager.requestPermitions {
            self.doneButtonIsDisabled = false
        }
//        self.dayOfWeak = dayOfWeak
    }
}

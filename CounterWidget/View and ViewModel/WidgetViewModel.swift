//
//  WidgetViewModel.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.


import SwiftUI

@Observable
final class WidgetViewModel {
    private let dateCalculator = DateCalculator()
    private (set) var eventTitle: String = ""
    private (set) var localizedTimeState: String = ""
    private (set) var number: String = ""
    private (set) var localizedDateType: String = ""
    private (set) var color: Color = .brown
    private (set) var inList: Bool = false

    private func fillFieldsWith(_ event: EventForTransfer) {
        let timeData = self.dateCalculator.allTimeDataFor(date: event.date, dateType: event.dateType)
        if let localizedTimeState = timeData["localizedTimeState"] {
            self.localizedTimeState = localizedTimeState
        }
        if let number = timeData["dateNumber"] {
            self.number = number
        }
        if let localizedDateType = timeData["localizedDateType"] {
            if timeData ["timeState"] != TimeStateType.present.label {
                self.localizedDateType = localizedDateType
            }
        }
        color = event.color.getColor
        eventTitle = event.title
    }
    
    private func searchForEvent(events: [EventForTransfer], eventID: String) {
        if let eventInList = events.first(where: { $0.id.uuidString == eventID }) {
            fillFieldsWith(eventInList)
            self.inList = true
        }
    }
    
    init(events: [EventForTransfer], eventID: String) {
        searchForEvent(events: events, eventID: eventID)
    }
}

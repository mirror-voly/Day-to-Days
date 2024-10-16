//
//  WidgetViewModel.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.


import SwiftUI

@Observable
final class WidgetViewModel {
    private let dateCalculator = DateCalculator()
    private (set) var inList = false
    private (set) var eventTitle = Constants.emptyString
    private (set) var localizedTimeState = Constants.emptyString
    private (set) var number = Constants.emptyString
    private (set) var localizedDateType = Constants.emptyString
    private (set) var color: Color = .brown

    private func setAllEventProperties(_ event: EventForTransfer) {
        let timeData = dateCalculator.allTimeDataFor(date: event.date, dateType: event.dateType)
        localizedTimeState = timeData[.localizedTimeState] ?? Constants.emptyString
        number = timeData[.dateNumber] ?? Constants.emptyString
        if timeData[.timeState] != TimeStateType.present.label {
			let dateType = timeData[.localizedDateType] ?? Constants.emptyString
            localizedDateType = dateType + " "
        }
        color = event.color.getColor
        eventTitle = event.title
    }
    
    private func searchForEvent(events: [EventForTransfer], eventID: String) {
        if let eventInList = events.first(where: { $0.id.uuidString == eventID }) {
            setAllEventProperties(eventInList)
            self.inList = true
        }
    }
    
    init(events: [EventForTransfer], eventID: String) {
        searchForEvent(events: events, eventID: eventID)
    }
}

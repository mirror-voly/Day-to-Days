//
//  WidgetViewModel.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.


import SwiftUI

@Observable
final class WidgetViewModel {
    private (set) var eventTitle: String = ""
    private (set) var localizedTimeState: String = ""
    private (set) var number: String = ""
    private (set) var localizedDateType: String = ""
    let dateCalculator = DateCalculator()

    func setTimeData(event: EventWidget?) {
        guard let event = event else { return }
        let timeData = dateCalculator.allTimeDataFor(date: event.date, dateType: event.dateType)
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
        eventTitle = event.title
    }
    
    init(events: [EventWidget], eventID: String) {
        setTimeData(event: events.first(where: { $0.id.uuidString == eventID }))
    }
}

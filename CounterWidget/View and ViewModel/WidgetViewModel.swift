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

    private func fillFieldsWith(_ event: EventForTransfer?) {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let event = event else { return }
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
            self.color = event.color.getColor
            self.eventTitle = event.title
        }
    }
    
    init(events: [EventForTransfer], eventID: String) {
        fillFieldsWith(events.first(where: { $0.id.uuidString == eventID }))
    }
}

//
//  WidgetViewModel.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.


import SwiftUI

@Observable
final class WidgetViewModel {
    private (set) var localizedTimeState: String = ""
    private (set) var number: String = ""
    private (set) var localizedDateType: String = ""
    let event: EventWidget
    let numberColor: Color
    let dateCalculator = DateCalculator()

    func setTimeData(event: EventWidget) {
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
    }
    
    init(event: EventWidget, numberColor: Color) {
        self.numberColor = numberColor
        self.event = event
        setTimeData(event: event)
    }
}

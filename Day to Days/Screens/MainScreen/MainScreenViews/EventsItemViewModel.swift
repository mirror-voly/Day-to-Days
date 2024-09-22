//
//  EventsItemViewModel.swift
//  Day to Days
//
//  Created by mix on 18.09.2024.
//

import Foundation

@Observable
final class EventsItemViewModel {
    private (set) var isSelected = false
    private (set) var timeData: [String: String]?
    private (set) var localizedTimeState: String = ""
    private (set) var number: String = ""
    private (set) var localizedDateType: String = ""

    func setTimeData(event: Event) {
        let timeData =  TimeUnitLocalizer.allTimeDataFor(event: event)
        if let localizedTimeState = timeData["localizedTimeState"] {
            self.localizedTimeState = localizedTimeState.capitalized
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

    func toggleSelected() {
        isSelected.toggle()
    }

    func changeSelectedToFalse() {
        isSelected = false
    }
}

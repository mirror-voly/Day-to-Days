//
//  EventsItemViewModel.swift
//  Day to Days
//
//  Created by mix on 18.09.2024.
//

import SwiftUI

@Observable
final class EventsItemViewModel {
    private let dateCalculator = DateCalculator()
    private (set) var isVisible = false
    private (set) var timeData: [String: String]?
    private (set) var localizedTimeState = Constants.emptyString
    private (set) var number = Constants.emptyString
    private (set) var localizedDateType = Constants.emptyString

    private var mainScreenViewModel: MainScreenViewModel
    private (set) var event: Event
    private (set) var isSelected = false
    var fillColor: Color {
        isSelected ? .primary : .colorScheme
    }

    var selectedColor: Color {
        isSelected ? Color.primary.opacity(Constants.selectedOpacity) :
        Color.primary.opacity(Constants.notSelectedOpacity)
    }

    private func setTimeData(event: Event) {
        let timeData = self.dateCalculator.allTimeDataFor(date: event.date, dateType: event.dateType)
        if let localizedTimeState = timeData[.localizedTimeState] {
            self.localizedTimeState = localizedTimeState.capitalized
        }
        if let number = timeData[.dateNumber] {
            self.number = number
        }
        if let localizedDateType = timeData[.localizedDateType] {
            if timeData [.timeState] != TimeStateType.present.label {
                self.localizedDateType = localizedDateType
            }
        }
    }

    func toggleSelected() {
        isSelected.toggle()
        mainScreenViewModel.toggleSelectedState(eventID: event.id)
        mainScreenViewModel.toggleSelection(eventID: event.id, isSelected: isSelected)
    }

    func changeSelectedToFalse() {
        isSelected = false
    }

    func isOutOfBounds(proxy: GeometryProxy) {
        let frame = proxy.frame(in: .global)
        let screenHeight = UIScreen.main.bounds.height
        let limit = Constraints.frameBoundsLimit
        isVisible = frame.maxY < limit || frame.minY + limit > screenHeight || frame.minY < limit
    }

    init(event: Event, mainScreenViewModel: MainScreenViewModel) {
        self.event = event
        self.mainScreenViewModel = mainScreenViewModel
        self.setTimeData(event: event)
    }
}

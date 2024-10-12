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
    private var mainScreenViewModel: MainScreenViewModel
    private (set) var event: Event
    private (set) var isSelected = false
    private (set) var isVisible = false
    private let timeData: [TimeDataReturnType: String]
    // MARK: - Calculated properties
    var fillColor: Color {
        isSelected ? .primary : .colorScheme
    }

    var selectedColor: Color {
        isSelected ? Color.primary.opacity(Constants.selectedOpacity) :
        Color.primary.opacity(Constants.notSelectedOpacity)
    }

    var localizedTimeState: String {
        timeData[.localizedTimeState]?.capitalized ?? Constants.emptyString
    }

    var number: String {
        timeData[.dateNumber] ?? Constants.emptyString
    }

    var localizedDateType: String {
        guard timeData[.timeState] == TimeStateType.present.label else {
            return timeData[.localizedDateType] ?? Constants.emptyString
        }
        return Constants.emptyString
    }
    // MARK: - Functions
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
        self.timeData = dateCalculator.allTimeDataFor(date: event.date, dateType: event.dateType)
    }
}

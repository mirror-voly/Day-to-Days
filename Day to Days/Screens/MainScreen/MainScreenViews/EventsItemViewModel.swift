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
    private let mainScreenViewModel: MainScreenViewModel
    private let eventID: UUID
    let localizedTimeState: String
    let number: String
    let localizedDateType: String
    let color: Color
    let title: String
    private (set) var isSelected = false
    private (set) var isVisible = false
    // MARK: - Calculated properties
    var circleHoleColor: Color {
        isSelected ? .primary : .colorScheme
    }

    var selectedOverlayColor: Color {
        isSelected ? Color.primary.opacity(Constants.selectedOpacity) :
        Color.primary.opacity(Constants.notSelectedOpacity)
    }
    // MARK: - Functions
    func toggleSelected() {
        isSelected.toggle()
        mainScreenViewModel.toggleSelectedState(eventID: eventID)
        mainScreenViewModel.toggleSelection(eventID: eventID, isSelected: isSelected)
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
        self.eventID = event.id
        self.color = event.color
        self.title = event.title
        self.mainScreenViewModel = mainScreenViewModel
        let timeData: [TimeDataReturnType: String] = dateCalculator.allTimeDataFor(date: event.date,
                                                                                   dateType: event.dateType)
        self.localizedTimeState = timeData[.localizedTimeState]?.capitalized ?? Constants.emptyString
        self.number = timeData[.dateNumber] ?? Constants.emptyString
        self.localizedDateType = (timeData[.timeState] != TimeStateType.present.label ?
                                  timeData[.localizedDateType]: Constants.emptyString) ?? Constants.emptyString
    }
}

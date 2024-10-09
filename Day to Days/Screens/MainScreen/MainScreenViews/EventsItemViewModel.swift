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
    private var index: Int
    private (set) var isVisible = false
    private (set) var timeData: [String: String]?
    private (set) var localizedTimeState = Constants.emptyString
    private (set) var number = Constants.emptyString
    private (set) var localizedDateType = Constants.emptyString
    private (set) var event = Event() {
        didSet {
            setTimeData(event: event)
        }
    }
    private var mainScreenViewModel: MainScreenViewModel? {
        didSet {
            updateEvent()
        }
    }
    private (set) var isSelected = false {
        didSet {
            guard let mainScreenViewModel = mainScreenViewModel else { return }
            mainScreenViewModel.toggleSelection(eventID: event.id,
                                                isSelected: isSelected)
        }
    }
    var fillColor: Color {
        isSelected ? .primary : .colorScheme
    }

    var selectedColor: Color {
        isSelected ? Color.primary.opacity(Constants.selectedOpacity) :
        Color.primary.opacity(Constants.notSelectedOpacity)
    }

    func setMainViewModel(_ viewModel: MainScreenViewModel) {
        self.mainScreenViewModel = viewModel
    }

    func updateEvent() {
        guard let mainScreenViewModel = mainScreenViewModel else { return }
        event = mainScreenViewModel.sortedEvents[index]
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
        if let uuid = mainScreenViewModel?.sortedEvents[index].id {
            mainScreenViewModel?.toggleSelectedState(eventID: uuid)
        }
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

    init(index: Int) {
        self.index = index
    }
}

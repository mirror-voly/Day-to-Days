//
//  EventsItemViewModel.swift
//  Day to Days
//
//  Created by mix on 18.09.2024.
//

import SwiftUI

@Observable
final class EventsItemViewModel {
    private var index: Int
    private (set) var timeData: [String: String]?
    private (set) var localizedTimeState: String = ""
    private (set) var number: String = ""
    private (set) var localizedDateType: String = ""
    private (set) var event: Event = Event() {
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
        if isSelected {
            return Color.primary
        } else {
            return Color.primary.inverted()
        }
    }

    var selectedColor: Color {
            isSelected ? Color.primary.opacity(0.1) : Color.primary.opacity(0.01)
    }

    func setMainViewModel(_ viewModel: MainScreenViewModel) {
        self.mainScreenViewModel = viewModel
    }

    func updateEvent() {
        guard let mainScreenViewModel = mainScreenViewModel else { return }
        self.event = mainScreenViewModel.sortedEvents[index]
    }

    private func setTimeData(event: Event) {
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
        withAnimation {
            isSelected.toggle()
            if let uuid = mainScreenViewModel?.sortedEvents[index].id {
                mainScreenViewModel?.toggleSelectedState(eventID: uuid)
            }
        }
    }

    func changeSelectedToFalse() {
        isSelected = false
    }

    init(index: Int) {
        self.index = index
    }
}

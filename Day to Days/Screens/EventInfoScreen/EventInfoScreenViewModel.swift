//
//  EventInfoScreenViewModel.swift
//  Day to Days
//
//  Created by mix on 18.09.2024.
//

import Foundation
import RealmSwift

@Observable
final class EventInfoScreenViewModel {
    let allDateTypes = DateType.allCases.reversed()
    private (set) var allInfoForCurrentDate: [DateType: String]?
    private (set) var localizedTimeState: String?
    var sheetIsOpened = false
    var alertIsPresented = false
    private func allInfoForDate(event: Event) {
        let info = DateCalculator.dateInfoForThis(date: event.date, dateType: event.dateType)
        allInfoForCurrentDate = info
    }

    private func allTimeDataFor(event: Event) {
        let timeState = DateCalculator.determineFutureOrPastForThis(date: event.date)
        let dateNumber = DateCalculator.findFirstDateFromTheTopFor(date: event.date, dateType: event.dateType)
        let localizedTimeState = TimeUnitLocalizer.localizeTimeState(for: dateNumber, state: timeState, dateType: event.dateType)
        self.localizedTimeState = localizedTimeState
    }

    func updateEditedEvent(eventID: UUID) -> Event? {
        do {
            let realm = try Realm()
            if let event = realm.object(ofType: Event.self, forPrimaryKey: eventID) {
                return event
            }
        } catch {
            print("Finding event error occurred: \(error.localizedDescription)")
        }
        return nil
    }

    func onAppearActions(event: Event) {
        allInfoForDate(event: event)
        allTimeDataFor(event: event)
    }
}

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
        let allInfo = DateCalculator.dateInfoForThis(date: event.date, dateType: event.dateType)
        allInfoForCurrentDate = allInfo
    }

    private func localizedTimeStateFor(event: Event) {
        localizedTimeState = TimeUnitLocalizer.getLocalizedTimeState(event: event)
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
        localizedTimeStateFor(event: event)
    }
}

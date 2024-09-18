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
    let allDateTypes = (DateType.allCases).reversed()
    private (set) var allInfoForCurrentDate: [DateType: String] = [:]

    func allInfoForDate(event: Event) {
        let info = DateCalculator.dateInfoForThis(date: event.date, dateType: event.dateType)
        allInfoForCurrentDate = info
    }

    func findEventBy(id: UUID) -> Event? {
        do {
            let realm = try Realm()
            if let event = realm.object(ofType: Event.self, forPrimaryKey: id) {
                return event
            }
        } catch {
            print("Finding event error occurred: \(error.localizedDescription)")
        }
        return nil
    }

    func updateEditedEvent(eventID: UUID) -> Event? {
        guard let finded = findEventBy(id: eventID) else { return nil}
        return finded
    }
}

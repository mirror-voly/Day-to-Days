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

    private (set) var allInfoForCurrentDate: [DateType: String]?
    let allDateTypes = DateType.allCases.reversed()
    var alertIsPresented = false
    var sheetIsOpened = false

    // MARK: - Calculated properties
    private (set) var event: Event {
        didSet {
            allInfoForDate(event: event)
        }
    }
    var localizedTimeState: String {
        TimeUnitLocalizer.getLocalizedTimeState(event: event).capitalized
    }
    var info: String {
        event.info.isEmpty ? "no_description".localized : event.info
    }
    // MARK: - Functions
    private func allInfoForDate(event: Event) {
        let allInfo = DateCalculator.dateInfoForThis(date: event.date, dateType: event.dateType)
        allInfoForCurrentDate = allInfo
    }

    func updateEditedEvent() {
        let eventID = event.id
        do {
            let realm = try Realm()
            if let event = realm.object(ofType: Event.self, forPrimaryKey: eventID) {
                setEvent(event: event)
            }
        } catch {
            print("Finding event error occurred: \(error.localizedDescription)")
        }
    }

    func setEvent(event: Event) {
        self.event = event
    }

    func reopenSheet() {
        sheetIsOpened = true
    }

    init(event: Event) {
        self.event = event
        allInfoForDate(event: event)
    }
}

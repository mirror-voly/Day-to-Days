//
//  EventInfoScreenViewModel.swift
//  Day to Days
//
//  Created by mix on 18.09.2024.
//

import SwiftUI
import RealmSwift

@Observable
final class EventInfoScreenViewModel {

    private (set) var allInfoForCurrentDate: [DateType: String]?
    let allDateTypes = DateType.allCases.reversed()
    let dateCalculator = DateCalculator()
    var sheetIsOpened = false
    // MARK: - Calculated properties
    private (set) var event: Event {
        didSet {
            allInfoForDate(event: event)
        }
    }
    var localizedTimeState: String {
        dateCalculator.getLocalizedTimeState(date: event.date, dateType: event.dateType).capitalized
    }
    var info: String {
        event.info.isEmpty ? "no_description".localized : event.info
    }
    // MARK: - Functions
    private func allInfoForDate(event: Event) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let allInfo = dateCalculator.dateInfoForThis(date: event.date, dateType: event.dateType)
            withAnimation {
                self.allInfoForCurrentDate = allInfo
            }
        }
    }

    func updateEditedEvent() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            do {
                let realm = try Realm()
                if let event = realm.object(ofType: Event.self, forPrimaryKey: event.id) {
                    setEvent(event: event)
                }
            } catch {
                print("Finding event error occurred: \(error.localizedDescription)")
            }
        }
    }

    func setEvent(event: Event) {
        withAnimation {
            self.event = event
        }
    }

    func reopenSheet() {
        sheetIsOpened = true
    }

    init(event: Event) {
        self.event = event
        allInfoForDate(event: event)
    }
}

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
    private (set) var event: Event
    var sheetIsOpened = false
    // MARK: - Calculated properties
    var localizedTimeState: String {
        dateCalculator.getLocalizedTimeState(date: event.date, dateType: event.dateType).capitalized
    }
    var info: String {
        event.info.isEmpty ? "no_description".localized : event.info
    }
    // MARK: - Functions
    private func getAllDateInfoFor(event: Event) {
        allInfoForCurrentDate = dateCalculator.dateInfoForThis(date: event.date, dateType: event.dateType)
    }

    func updateEditedEvent(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let realm = try Realm()
            if let newEvent = realm.object(ofType: Event.self, forPrimaryKey: event.id) {
                self.event = newEvent
                getAllDateInfoFor(event: newEvent)
                completion(.success(()))
            }
        } catch {
            completion(.failure(error))
        }
    }
    // MARK: - Init
    init(event: Event) {
        self.event = event
        getAllDateInfoFor(event: event)
    }
}

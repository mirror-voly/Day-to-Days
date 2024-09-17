//
//  AddOrEditEventSheetViewModel.swift
//  Day to Days
//
//  Created by mix on 17.09.2024.
//

import SwiftUI
import RealmSwift

@Observable
final class AddOrEditEventSheetViewModel {
    private (set) var screenMode: EditModeType?
    private (set) var currentEvent: Event?
//    private var canChange: Bool = true
    private var fixedDate = Date()
    var addButtonIsVisible = false
    var sliderValue: Double = 0
    var canDismiss = true
    var buttonSpacer: CGFloat = 0

    var event: Event?

    var title: String = "" {
            didSet {
//                if canChange {
                canDismiss = !areFieldsEmpty()
                addButtonIsVisible = title.isEmpty ? false : true
//            }
        }
    }
    var info = "" {
        didSet {
//            if canChange {
                canDismiss = !areFieldsEmpty()
//            }
        }
    }
    var date = Date() {
        didSet {
//            if canChange {
                canDismiss = !areFieldsEmpty()
//            }
        }
    }
    var color = Color.gray {
        didSet {
//            if canChange {
                canDismiss = !areFieldsEmpty()
//            }
        }
    }
    var dateType: DateType = .day {
        didSet {
//            if canChange {
                canDismiss = !areFieldsEmpty()
//            }
        }
    }

    var sheetTitle: String {
        screenMode == .edit ? "edit_event".localized: "new_event".localized
    }
    // MARK: - Functions

    func createEvent(id: UUID?) -> Event {
        return Event(
            id: id ?? UUID(),
            title: title,
            info: info,
            date: date,
            dateType: dateType,
            color: color
        )
    }

    private func areFieldsEmpty() -> Bool {
        title != "" || info != "" || color != Color.gray || dateType != .day || date != fixedDate
    }

    func extractEventData() {
        let eventToUpdate = currentEvent ?? event
        updateFieldsFrom(eventToUpdate)
    }

    func updateFieldsFrom(_ event: Event?) {
        guard let event = event else { return }
        title = event.title
        info = event.info
        date = event.date
        color = event.color
        dateType = event.dateType
    }

    func dismissAlertPrepare(oldEventID: UUID?, action: () -> Void) {
        guard !canDismiss else { return }
        let event = createEvent(id: oldEventID)
        setCurrentEvent(event: event)
        action()
    }

    func buttonAction(oldEventID: UUID?, event: Event) {
        if let oldEventID = oldEventID {
            editEvent(oldEventID: oldEventID, newEvent: event)
        } else {
            addEvent(event: event)
        }
        makeCurrentEventNil()
    }

    func setCurrentEvent(event: Event) {
        currentEvent = event
    }

    func setScreenMode(mode: EditModeType) {
        screenMode = mode
    }

    func makeCurrentEventNil() {
        screenMode = nil
        currentEvent = nil
        canDismiss = true
        event = nil
    }

    func addEvent(event: Event) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(event)
            }
        } catch {
            print("Adding error occurred: \(error.localizedDescription)")
        }
    }

    func editEvent(oldEventID: UUID, newEvent: Event) {
        do {
            let realm = try Realm()
            if let eventToUpdate = realm.object(ofType: Event.self, forPrimaryKey: oldEventID) {
                try realm.write {
                    eventToUpdate.title = newEvent.title
                    eventToUpdate.info = newEvent.info
                    eventToUpdate.date = newEvent.date
                    eventToUpdate.dateType = newEvent.dateType
                    eventToUpdate.color = newEvent.color
                }
            }
        } catch {
            print("Editing error occurred: \(error.localizedDescription)")
        }
    }
    init() {
        extractEventData()
    }
    deinit {
        print("deinit")
    }
}

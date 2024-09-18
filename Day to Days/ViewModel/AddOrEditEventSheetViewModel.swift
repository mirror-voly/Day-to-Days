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
    enum ButtonSpacerType {
        case minimize
        case maximize
        var value: Double {
            switch self {
            case .minimize:
                return Сonstraints.buttonSpaсerMinimize
            case .maximize:
                return Сonstraints.buttonSpaсerMaximize
            }
        }
    }

    private var screenMode: EditModeType?
    private var currentEvent: Event?
    private var fixedDate = Date()
    private var canDismiss = true
    private (set) var addButtonIsVisible = false
    var sliderValue: Double = 0
    var buttonSpacer: ButtonSpacerType = .minimize
    var sheetTitle: String {
        screenMode == .edit ? "edit_event".localized: "new_event".localized
    }
    private let helpStrings = [
        "day_help", "week_help", "month_help", "year_help", "days_help"
    ]

    // MARK: - User fields
    var title: String = "" {
            didSet {
                canDismiss = !areFieldsEmpty()
                addButtonIsVisible = title.isEmpty ? false : true
        }
    }
    var info = "" {
        didSet {
                canDismiss = !areFieldsEmpty()
        }
    }
    var date = Date() {
        didSet {
                canDismiss = !areFieldsEmpty()
        }
    }
    var color = Color.gray {
        didSet {
                canDismiss = !areFieldsEmpty()
        }
    }
    var dateType: DateType = .day {
        didSet {
                canDismiss = !areFieldsEmpty()
            sliderValue = DateCalculator.findIndexForThis(dateType: dateType)
        }
    }
    // MARK: - Functions
    private func updateFieldsFrom(_ event: Event?) {
        title = event?.title ?? ""
        info = event?.info ?? ""
        date = event?.date ?? fixedDate
        color = event?.color ?? Color.gray
        dateType = event?.dateType ?? DateType.day
    }

    private func areFieldsEmpty() -> Bool {
        title != "" || info != "" || color != Color.gray || dateType != .day || date != fixedDate
    }

    private func setCurrentEvent(event: Event) {
        currentEvent = event
    }

    private func addEvent(event: Event) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(event)
            }
        } catch {
            print("Adding error occurred: \(error.localizedDescription)")
        }
    }

    private func editEvent(oldEventID: UUID, newEvent: Event) {
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

    func extractEventData(event: Event?) {
        let eventToUpdate = currentEvent ?? event
        updateFieldsFrom(eventToUpdate)
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

    func setScreenMode(mode: EditModeType) {
        screenMode = mode
    }

    func makeCurrentEventNil() {
        screenMode = nil
        currentEvent = nil
        canDismiss = true
    }

    func addHelpToTheButtonsBy(_ index: Int) -> String {
        return index < helpStrings.count ? helpStrings[index] : helpStrings.last!
    }
}

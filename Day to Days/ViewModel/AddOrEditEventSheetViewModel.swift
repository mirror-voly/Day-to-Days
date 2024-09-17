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

    var fieldsAreNotEmpy = false
    var addButtonIsVisible = false
    var canDismiss = true
    var buttonSpacer: CGFloat = 0

    // MARK: - Functions

    func buttonAction(oldEventID: UUID?, event: Event) {
        if let oldEventID = oldEventID {
            editEvent(oldEventID: oldEventID, newEvent: event)
        } else {
            addEvent(event: event)
        }
        makeCurrentEventNil()
    }

    var sheetTitle: String {
        screenMode == .edit ? "edit_event".localized: "new_event".localized
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
}

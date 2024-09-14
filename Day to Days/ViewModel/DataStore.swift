//
//  DataStore.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//
import RealmSwift
import SwiftUI

@Observable
final class DataStore {

    enum EditModeType {
        case edit
        case add
    }
    // MARK: - Private variables
    private (set) var screenMode: EditModeType?
    private (set) var currentEvent: Event?
    private (set)var noSelectedEvents = true
    private var selectedEvents: Set<UUID> = [] {
           didSet {
               noSelectedEvents = selectedEvents.isEmpty
           }
       }
    // MARK: - Functions for changing local variables
    func insertToSelectedEvents(eventID: UUID) {
        selectedEvents.insert(eventID)
    }

    func removeFromSelectedEvents(eventID: UUID) {
        selectedEvents.remove(eventID)
    }

    func makeSelectedEventsEmpty() {
        selectedEvents = []
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

    func removeSelectedEvents() {
        guard !noSelectedEvents else { return }
        for eventID in selectedEvents {
            do {
                let realm = try Realm()
                try realm.write {
                    if let eventToDelete = realm.object(ofType: Event.self, forPrimaryKey: eventID) {
                        realm.delete(eventToDelete)
                    }
                }
            } catch {
                print("Adding error occurred: \(error.localizedDescription)")
            }
        }
        makeSelectedEventsEmpty()
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

    func findEventBy(id: UUID) -> Event? {
        do {
            let realm = try Realm()
            if let event = realm.object(ofType: Event.self, forPrimaryKey: id) {
                return event
            }
        } catch {
            print("Finding error occurred: \(error.localizedDescription)")
        }
        return nil
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

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
    private (set) var editedEvent: Event?
    private (set) var allEvents: [Event] = []
    // MARK: - Functions for changing local variables
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

    func makeEditedEventNil() {
        editedEvent = nil
    }

    func addAndSaveEvent(event: Event) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(event)
            }
        } catch {
            print("Adding error occurred: \(error.localizedDescription)")
        }
    }

    func editEvent(newEvent: Event) {
        guard let currentEvent = currentEvent else { return }
        do {
            let realm = try Realm()
            if let eventToUpdate = realm.object(ofType: Event.self, forPrimaryKey: currentEvent.id) {
                try realm.write {
                    eventToUpdate.title = newEvent.title
                    eventToUpdate.info = newEvent.info
                    eventToUpdate.date = newEvent.date
                    eventToUpdate.dateType = newEvent.dateType
                    eventToUpdate.color = newEvent.color
                }
                editedEvent = newEvent
            }
        } catch {
            print("Editing error occurred: \(error.localizedDescription)")
        }
    }

    func deleteEventAt(_ index: IndexSet) {
        do {
            let realm = try Realm()
            try realm.write {
                for item in index {
                    realm.delete(allEvents[item])
                }
            }
        } catch {
            print("Deleting error occurred: \(error.localizedDescription)")
        }
    }

    func loadEvents() {
        do {
            let realm = try Realm()
            let events = realm.objects(Event.self)
            for event in events {
                allEvents.append(event)
            }
        } catch {
            print("Ошибка при инициализации Realm: \(error.localizedDescription)")
        }
    }

    init() {
        loadEvents()
    }
}

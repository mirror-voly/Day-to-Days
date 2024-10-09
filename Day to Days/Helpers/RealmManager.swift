//
//  RealmManager.swift
//  Day to Days
//
//  Created by mix on 09.10.2024.
//

import RealmSwift
import Foundation

final class RealmManager {
    static func removeEventBy(eventID: UUID) {
        do {
            let realm = try Realm()
            try realm.write {
                if let eventToDelete = realm.object(ofType: Event.self, forPrimaryKey: eventID) {
                    realm.delete(eventToDelete)
                }
            }
        } catch {
            print("Removing error occurred: \(error.localizedDescription)")
        }
    }

    static func addEvent(event: Event) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(event)
            }
        } catch {
            print("Adding error occurred: \(error.localizedDescription)")
        }
    }

    static func editEvent(newEvent: Event) {
        do {
            let realm = try Realm()
            if let eventToUpdate = realm.object(ofType: Event.self, forPrimaryKey: newEvent.id) {
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

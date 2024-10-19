//
//  RealmManager.swift
//  Day to Days
//
//  Created by mix on 09.10.2024.
//

import RealmSwift
import Foundation

final class RealmManager {
    static func removeEventBy(eventID: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                if let eventToDelete = realm.object(ofType: Event.self, forPrimaryKey: eventID) {
                    realm.delete(eventToDelete)
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

    static func addEvent(event: Event, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(event)
                completion(.success(()))
            }
        } catch {
            completion(.failure(error))
        }
    }

    static func editEvent(newEvent: Event, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let realm = try Realm()
            if let eventToUpdate = realm.object(ofType: Event.self, forPrimaryKey: newEvent.id) {
                try realm.write {
                    eventToUpdate.title = newEvent.title
                    eventToUpdate.info = newEvent.info
                    eventToUpdate.date = newEvent.date
                    eventToUpdate.dateType = newEvent.dateType
                    eventToUpdate.color = newEvent.color
					eventToUpdate.imageData = newEvent.imageData
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

	static func findEditedEvent(eventID: UUID, completion: @escaping (Result<Void, Error>) -> Void) -> Event? {
		do {
			let realm = try Realm()
			if let newEvent = realm.object(ofType: Event.self, forPrimaryKey: eventID) {
				completion(.success(()))
				return newEvent
			}
		} catch {
			completion(.failure(error))
		}
		return nil
	}
}

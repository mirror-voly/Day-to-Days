//
//  SearchTransferEvent.swift
//  Day to Days
//
//  Created by mix on 17.10.2024.
//

import Foundation

final class LoadTransferEvent {
	private let userDefaults = UserDefaults(suiteName: Constants.suiteName)
	
	private func loadEvents() -> Data? {
		userDefaults?.data(forKey: Constants.widgetStorage)
	}
	
	func findEventByID(_ eventIDString: String) -> EventForTransfer? {
		guard let data = loadEvents() else { return nil }
		do {
			let decoded = try JSONDecoder().decode([EventForTransfer].self, from: data)
			guard let eventID = UUID(uuidString: eventIDString) else { return nil }
			let event = decoded.first(where: { $0.id == eventID })
			return event
		} catch {
			return nil
		}	
	}
	
}

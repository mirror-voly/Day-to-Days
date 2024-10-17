//
//  URLPathOpener.swift
//  Day to Days
//
//  Created by mix on 17.10.2024.
//

import Foundation

final class EventSearch {

	static func findEventByURL(url: URL, events: [Event], completion: (Event) -> Void) {
		guard let urlHost = url.host(), let eventID = UUID(uuidString: urlHost) else { return }
		if let event = events.first(where: {$0.id == eventID }) {
			completion(event)
		}
	}
}

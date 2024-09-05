//
//  DataStore.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import Foundation
@Observable
final class DataStore {
    private (set) var allEvents: [Event] = [Event(title: "My first try", description: "", date: ISO8601DateFormatter().date(from: "2025-03-15T14:30:00Z")!, dateType: .day, color: .red),
                              Event(title: "Meeting", description: "well it something", date: ISO8601DateFormatter().date(from: "2024-03-11T14:30:00Z")!, dateType: .day, color: .teal),
                              Event(title: "Guitar train", description: "lol what", date: Date(), dateType: .day, color: .black),
                              Event(title: "Paiment for rent", description: "best day on my life", date: ISO8601DateFormatter().date(from: "2021-03-15T14:30:00Z")!, dateType: .day, color: .pink)]

    func addEvent(event: Event) {
        allEvents.append(event)
    }

    func editEvent(oldEvent: Event, newEvent: Event) {
        guard let index = allEvents.firstIndex(of: oldEvent) else { return }
        allEvents[index] = newEvent
    }
}

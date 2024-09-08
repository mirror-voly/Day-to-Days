//
//  DataStore.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import Foundation

@Observable
final class DataStore {
    enum EditModeType {
        case edit
        case add
    }
    var screenMode: EditModeType?
    var currentEvent: Event?

    private (set) var allEvents: [Event] = []

    func addEvent(event: Event) {
        allEvents.append(event)
    }

    func editEvent(newEvent: Event) {
        guard let currentEvent = currentEvent else { return }
        if let index = allEvents.firstIndex(where: { $0.id == currentEvent.id }) {
            allEvents[index] = newEvent
        }
    }

    func deleteEventAt(_ index: IndexSet) {
        allEvents.remove(atOffsets: index)
    }

    func makeCurrentEventNil() {
        screenMode = nil
        currentEvent = nil
    }

    private func addUITestData() {
        allEvents.append(contentsOf: [Event(title: "My first try", description: "", date: ISO8601DateFormatter().date(from: "2025-03-15T14:30:00Z")!, dateType: .day, color: .red),
                                      Event(title: "Meeting", description: "well it something", date: ISO8601DateFormatter().date(from: "2024-03-11T14:30:00Z")!, dateType: .day, color: .teal),
                                      Event(title: "Paiment for rent", description: "best day", date: ISO8601DateFormatter().date(from: "2021-03-15T14:30:00Z")!, dateType: .day, color: .pink)])
    }

    init() {
        addUITestData()
    }
}

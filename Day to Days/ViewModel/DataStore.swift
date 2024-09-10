//
//  DataStore.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

@Observable
final class DataStore {
    enum EditModeType {
        case edit
        case add
    }
    private (set) var screenMode: EditModeType?
    private (set) var currentEvent: Event?
    private (set) var editedEvent: Event?
    private (set) var allEvents: [Event] = []

    func setCurrentEvent(event: Event) {
        currentEvent = event
    }

    func setScreenMode(mode: EditModeType) {
        screenMode = mode
    }

    func addEvent(event: Event) {
        allEvents.append(event)
    }

    func editEvent(newEvent: Event) {
        guard let currentEvent = currentEvent else { return }
        if let index = allEvents.firstIndex(where: { $0.id == currentEvent.id }) {
            allEvents[index] = newEvent
            editedEvent = newEvent
        }
    }

    func deleteEventAt(_ index: IndexSet) {
        allEvents.remove(atOffsets: index)
    }

    func makeCurrentEventNil() {
        screenMode = nil
        currentEvent = nil
    }

    func makeEditedEventNil() {
        editedEvent = nil
    }

    private func addUITestData() {
        allEvents.append(contentsOf: [Event(title: "My first try", info: "", date: ISO8601DateFormatter().date(from: "2025-03-15T14:30:00Z")!, dateType: .day, color: .red),
                                      Event(title: "Meeting", info: "flight on the morning", date: ISO8601DateFormatter().date(from: "2020-03-11T14:30:00Z")!, dateType: .year, color: .teal),
                                      Event(title: "Open air", info: "well it something", date: ISO8601DateFormatter().date(from: "2024-03-11T14:30:00Z")!, dateType: .day, color: .indigo),
                                      Event(title: "Weekends", info: "Horrey, actualy good sing", date: ISO8601DateFormatter().date(from: "2022-01-11T14:30:00Z")!, dateType: .month, color: .brown),
                                      Event(title: "Home works", info: "should to do somethin", date: ISO8601DateFormatter().date(from: "2027-06-11T14:30:00Z")!, dateType: .weak, color: .blue),
                                      Event(title: "Paiment for rent", info: "best day", date: ISO8601DateFormatter().date(from: "2021-03-15T14:30:00Z")!, dateType: .day, color: .pink)
                                     ])
    }

    init() {
        addUITestData()
    }
}

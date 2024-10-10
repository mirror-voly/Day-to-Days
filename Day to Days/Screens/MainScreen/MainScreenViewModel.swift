//
//  DataStore.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//
import RealmSwift
import SwiftUI

@Observable
final class MainScreenViewModel {
    // MARK: - Private variables
    private (set) var selectedState: [UUID: Bool] = [:]
    private (set) var noSelectedEvents = true
    private (set) var navigationLinkIsPresented = false
    private (set) var sortBy: SortType = .none
    private (set) var imageName = "arrow.up.circle"
    private (set) var editIsActivated = false
    private var events: Results<Event>?

    var sheetIsOpened = false
    var emptyViewIsAnimating = false

    private (set) var ascending = true {
        didSet {
            imageName = ascending ? "arrow.up.circle" : "arrow.down.circle"
        }
    }
    private var selectedEvents: Set<UUID> = [] {
        didSet {
            noSelectedEvents = selectedEvents.isEmpty
        }
    }
    // MARK: - Calculated properties
    var sortedEvents: [Event] {
        guard let events = events else { return []}
        return SortEvents.sortResulsBy(allEvents: events, sortBy: sortBy, ascending: ascending).reversed()
    }
    var eventsIsEmpty: Bool {
        sortedEvents.isEmpty
    }
    // MARK: - Functions
    private func insertToSelectedEvents(eventID: UUID) {
        selectedEvents.insert(eventID)
    }

    private func removeFromSelectedEvents(eventID: UUID) {
        selectedEvents.remove(eventID)
    }

    func toggleSelectedState(eventID: UUID) {
        selectedState[eventID, default: false].toggle()
    }

    func toggleSelection(eventID: UUID, isSelected: Bool) {
        if isSelected {
            insertToSelectedEvents(eventID: eventID)
        } else {
            removeFromSelectedEvents(eventID: eventID)
        }
    }

    func makeSelectedEventsEmpty() {
        selectedEvents = []
        setEditMode(set: false)
    }

    func removeEventBy(_ index: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let eventID = sortedEvents[index].id
        toggleSelection(eventID: eventID, isSelected: true)
        removeSelectedEvents(completion: { result in
            completion(result)
        })
    }

    func removeSelectedEvents(completion: @escaping (Result<Void, Error>) -> Void) {
        if !self.noSelectedEvents {
            selectedEvents.forEach({ eventID in
                RealmManager.removeEventBy(eventID: eventID, completion: { result in
                    completion(result)
                })
            })
        }
        self.makeSelectedEventsEmpty()
    }

    func sortButtonAction(type: SortType) {
        sortBy = type
        if type != .none {
            ascending.toggle()
        }
    }

    func setEvents(allEvents: Results<Event>) {
        self.events = allEvents
    }

    func setEditMode(set: Bool) {
        editIsActivated = set
    }
}

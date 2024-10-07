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
    var isAnimating = false

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
        let result: [Event] = sortResulsBy(allEvents: events, sortBy: sortBy, ascending: ascending).reversed()
        return result
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

    private func sortResulsBy(allEvents: Results<Event>, sortBy: SortType, ascending: Bool) -> [Event] {
        allEvents.sorted {
            switch sortBy {
            case .date:
                let lhs = $0[keyPath: \Event.date] as Date
                let rhs = $1[keyPath: \Event.date] as Date
                return ascending ? lhs < rhs : lhs > rhs
            case .title:
                let lhs = $0[keyPath: \Event.title] as String
                let rhs = $1[keyPath: \Event.title] as String
                return ascending ? lhs < rhs : lhs > rhs
            default:
                return true
            }
        }
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

    func removeEventBy(_ index: Int) {
        let eventID = sortedEvents[index].id
        toggleSelection(eventID: eventID, isSelected: true)
        removeSelectedEvents()
    }

    func removeSelectedEvents() {
        DispatchQueue.main.async {
            if !self.noSelectedEvents {
                for eventID in self.selectedEvents {
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
            }
            self.makeSelectedEventsEmpty()
        }
    }

    func sortButtonAction(type: SortType) {
        sortBy = type
        if type != .none {
            ascending.toggle()
        }
    }

    func setEvents(allEvents: Results<Event>) {
        self.events = allEvents
        WidgetManager.sendToWidgetsThis(Array(allEvents))
    }

    func setEditMode(set: Bool) {
        editIsActivated = set
    }
}

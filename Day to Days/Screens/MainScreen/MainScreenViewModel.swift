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
    private var alertManager: AlertManager?

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
        let result: [Event] = SortEvents.sortResulsBy(allEvents: events,
                                                      sortBy: sortBy,
                                                      ascending: ascending).reversed()
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
        if !self.noSelectedEvents {
            selectedEvents.forEach({ eventID in
                RealmManager.removeEventBy(eventID: eventID, completion: { [self] result in
                    guard let alertManager = alertManager else { return }
                    alertManager.getIdentifiebleErrorFrom(result: result)
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
        WidgetManager.sendToWidgetsThis(Array(allEvents), completion: { [self] result in
            guard let alertManager = alertManager else { return }
            alertManager.getIdentifiebleErrorFrom(result: result)
        })
    }

    func setEditMode(set: Bool) {
        editIsActivated = set
    }

    func setAlertManager(alertManager: AlertManager) {
        self.alertManager = alertManager
    }
}

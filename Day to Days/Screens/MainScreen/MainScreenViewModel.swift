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
	let notificationManager: NotificationManager
	let settingsManager: SettingsManager
    private (set) var selectedState: [UUID: Bool] = [:]
	private (set) var editIsActivated = false
    private (set) var noSelectedEvents = true
    private (set) var navigationLinkIsPresented = false
    private (set) var sortBy: SortType = .none
	var imageSortIcon: String {
		ascending ? "arrow.up.circle" : "arrow.down.circle"
	}
	var imageSortIconReversed: String {
		ascending ? "arrow.down.circle" : "arrow.up.circle"
	}
	
    private var events: Results<Event>?

	var path = NavigationPath()
    var sheetIsOpened = false
    var emptyViewIsAnimating = false
	var settingsFullScreenCover = false

    private (set) var ascending = true
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

    func removeEventBy(_ eventID: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
        insertToSelectedEvents(eventID: eventID)
        removeSelectedEvents(completion: { result in
            completion(result)
        })
    }

    func removeSelectedEvents(completion: @escaping (Result<Void, Error>) -> Void) {
        if !self.noSelectedEvents {
            selectedEvents.forEach({ eventID in
				RealmManager.removeEventBy(eventID: eventID, completion: { [self] result in
					switch result {
						case .success(()):
							notificationManager.removeScheduledNotification(eventStringID: eventID.uuidString)
						case .failure(let error):
							completion(result)
					}
                })
            })
        }
        self.makeSelectedEventsEmpty()
    }

    func sortButtonAction(type: SortType, completion: @escaping (Result<Void, Error>) -> Void) {
        sortBy = type
		
        if type != .none {
            ascending.toggle()
        }
		
		settingsManager.saveSettings(sortType: type, ascending: ascending, completion: { result in
			completion((result))
		})
    }
	
	func setLoadedSettings(completion: @escaping (Result<Void, Error>) -> Void) {
		let settings = settingsManager.loadSettings { result in
			completion((result))
		}
		guard let settings = settings else { return }
			sortBy = settings.sortType
			ascending = settings.ascending
	}

    func setEvents(allEvents: Results<Event>) {
        self.events = allEvents
    }

    func setEditMode(set: Bool) {
        editIsActivated = set
    }
	
	init(notificationManager: NotificationManager, settingsManager: SettingsManager) {
		self.settingsManager = settingsManager
		self.notificationManager = notificationManager
	}
}

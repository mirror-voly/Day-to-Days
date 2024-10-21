//
//  EventInfoScreenViewModel.swift
//  Day to Days
//
//  Created by mix on 18.09.2024.
//

import SwiftUI

@Observable
final class EventInfoScreenViewModel {
	
	enum EventInfoScreenSheetType {
		case edit, notificatiom, share, non
	}
	
    private (set) var allInfoForCurrentDate: [DateType: String]?
    private (set) var event: Event
	var scale = Constraints.originalSize
	var toolBarVisibility: Visibility = .visible
	
    var editSheetIsOpened = false
    var notificationSheetIsOpened = false
	var shareSheetIsOpened = false
	
	var overlay: Image?
    let allDateTypes = DateType.allCases.reversed()
    let dateCalculator = DateCalculator()
    // MARK: - Calculated properties
    var localizedTimeState: String {
        dateCalculator.getLocalizedTimeState(date: event.date, dateType: event.dateType).capitalized
    }
    var info: String {
        event.info.isEmpty ? "no_description".localized : event.info
    }
    // MARK: - Functions
    private func getAllDateInfoFor(event: Event) {
        allInfoForCurrentDate = dateCalculator.dateInfoForThis(date: event.date, dateType: event.dateType)
    }

	func updateEditedEventOnDismiss(completion: @escaping (Result<Void, Error>) -> Void) {
		guard let newEvent = RealmManager.findEditedEvent(eventID: event.id, completion:  { result in
			completion(result)
		}) else { return }
		self.event = newEvent
		getAllDateInfoFor(event: newEvent)
	}

    // MARK: - Init
    init(event: Event) {
        self.event = event
        getAllDateInfoFor(event: event)
    }
}

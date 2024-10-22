//
//  EventInfoScreenViewModel.swift
//  Day to Days
//
//  Created by mix on 18.09.2024.
//

import SwiftUI

@Observable
final class EventInfoScreenViewModel {
	let dateCalculator: DateCalculator
	let imageGenerator: ImageGenerator
	let allDateTypes = DateType.allCases.reversed()
	
    private (set) var allInfoForCurrentDate: [DateType: String]
    private (set) var event: Event
	var overlay: Image?

	var scale = Constraints.originalSize
	var toolBarVisibility: Visibility = .visible
	
    var editSheetIsOpened = false
    var notificationSheetIsOpened = false

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

	func shareButtonAction(completion: @escaping (Result<Void, Error>) -> Void) {
		imageGenerator.makeImage(content: ShareImageView(title: event.title,
														 localizedTimeState: localizedTimeState,
														 dateTypes: allDateTypes,
														 allInfoForCurrentDate: allInfoForCurrentDate,
														 dateCalculator: dateCalculator,
														 color: event.color),
								 completion: { [self] result in
			switch result {
				case .success(let image):
					overlay = image
				case .failure(_):
					let error = NSError(domain: "Share button error", code: 0)
					completion(.failure(error))
			}
		})
	}

    // MARK: - Init
	init(event: Event, imageGenerator: ImageGenerator, dateCalculator: DateCalculator) {
        self.event = event
		self.dateCalculator = dateCalculator
		self.allInfoForCurrentDate = dateCalculator.dateInfoForThis(date: event.date, dateType: event.dateType)
		self.imageGenerator = imageGenerator
    }
}

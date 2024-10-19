//
//  AddOrEditEventSheetViewModel.swift
//  Day to Days
//
//  Created by mix on 17.09.2024.
//

import SwiftUI
import PhotosUI

@Observable
final class AddOrEditEventSheetViewModel {
	let notificationManager: NotificationManager
    private var screenMode: ScreenModeType?
    private var eventID: UUID?

	var photoItem: PhotosPickerItem? {
		didSet {
			makePhotoData()
			photoItemIsNotEmpty = photoItem == nil ? false : true
		}
	}
	private (set) var photoItemIsNotEmpty = false
	private var photoData: Data?

    var actionSheetIsPresented = false
    var aninmateDateButton = false
	var addButtonIsVisible = false
    private (set) var dragOffset = CGSize.zero
    // MARK: - User fields
    var title = Constants.emptyString {
        didSet {
            addButtonIsVisible = title.isEmpty ? false : true
        }
    }
    var info = Constants.emptyString
    var date = Date()
    private (set) var dateType: DateType = .day
    private (set) var color: Color = .gray
    private (set) var sliderValue: Double = .zero {
        didSet {
            dateType = .allCases[Int(sliderValue)]
        }
    }
    private let helpStrings = [
        "day_help", "week_help", "month_help", "year_help", "days_help"
    ]
    // MARK: - Calculated properties
    var sheetTitle: String {
        screenMode == .edit ? "edit_event".localized: "new_event".localized
    }
	private var dateStart: Date {
		let calendar = Calendar.current
		var components = calendar.dateComponents([.year, .month, .day], from: date)
		components.hour = 0
		components.minute = 0
		components.second = 0
		return calendar.date(from: components) ?? date
	}
    // MARK: - Functions
    private func findIndexForThis(dateType: DateType) -> Double { // for slider value
        guard let index = DateType.allCases.firstIndex(of: dateType) else { return .zero }
        return Double(index)
    }
	
	private func makePhotoData() {
		guard let photoItem = photoItem else { 
			self.photoData = nil
			return 
		}
		photoItem.loadTransferable(type: Data.self) { result in
			switch result {
			case .success(let data):
				self.photoData = data
			case .failure(_):
				self.photoData = nil
			}
		}
	}

    func updateFieldsFrom(_ event: Event?) {
        guard let event = event else { return }
        eventID = event.id
        title = event.title
        info = event.info
        date = event.date
        color = event.color
        dateType = event.dateType
        sliderValue = findIndexForThis(dateType: dateType)
		photoItemIsNotEmpty = (event.imageData != nil)
		photoData = event.imageData
    }

    func createEvent(id: UUID?) -> Event {
        return Event(
            id: id ?? UUID(),
            title: title,
            info: info,
            date: dateStart,
            dateType: dateType,
            color: color,
			imageData: photoData
        )
    }

    func buttonAction(completion: @escaping (Result<Void, Error>) -> Void) {
        let event = createEvent(id: eventID)
        if screenMode == .edit {
			RealmManager.editEvent(newEvent: event, completion: { [self] result in
				switch result {
					case .success(()):
						notificationManager.updateNotificatioIfNeeded(event: event, completion: { result in
							completion(result)
						})
					case .failure(let error):
						completion(result)
				}
            })
        } else {
            RealmManager.addEvent(event: event, completion: { result in
                completion(result)
            })
        }
    }

    func setScreenMode(mode: ScreenModeType) {
        screenMode = mode
    }

    func addHelpToButtonsBy(_ index: Int) -> String {
        return index < helpStrings.count ? helpStrings[index] : helpStrings.last!
    }

    func setSliderValue(value: Double) {
        sliderValue = Double(value)
    }

    func setColor(color: Color) {
        self.color = color
    }

    func getColorForMenuItem(currentColor: ColorType) -> Color {
        color.getColorType == currentColor ? .colorScheme : .clear
    }

    func dragOffsetForSheetFrom(_ value: DragGesture.Value) {
        dragOffset = value.translation
        if value.translation.height > Constraints.dragGestureDistance {
            actionSheetIsPresented = true
            dragOffset = .zero
        }
    }
	
	func clearImage() {
		photoItem = nil
	}

	init(notificationManager: NotificationManager) {
		self.notificationManager = notificationManager
	}
}

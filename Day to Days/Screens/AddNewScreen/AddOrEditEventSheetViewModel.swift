//
//  AddOrEditEventSheetViewModel.swift
//  Day to Days
//
//  Created by mix on 17.09.2024.
//

import SwiftUI

@Observable
final class AddOrEditEventSheetViewModel {
    private var screenMode: ScreenModeType?
    private var eventID: UUID?
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

    func updateFieldsFrom(_ event: Event?) {
        guard let event = event else { return }
        eventID = event.id
        title = event.title
        info = event.info
        date = event.date
        color = event.color
        dateType = event.dateType
        sliderValue = findIndexForThis(dateType: dateType)
    }

    func createEvent(id: UUID?) -> Event {
        return Event(
            id: id ?? UUID(),
            title: title,
            info: info,
            date: dateStart,
            dateType: dateType,
            color: color
        )
    }

    func buttonAction(completion: @escaping (Result<Void, Error>) -> Void) {
        let event = createEvent(id: eventID)
		print(event)
        if screenMode == .edit {
            RealmManager.editEvent(newEvent: event, completion: { result in
                completion(result)
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
}

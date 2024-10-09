//
//  AddOrEditEventSheetViewModel.swift
//  Day to Days
//
//  Created by mix on 17.09.2024.
//

import SwiftUI
import RealmSwift

@Observable
final class AddOrEditEventSheetViewModel {
    private var screenMode: ScreenModeType?
    private var event: Event?
    var alertManager: AlertManager?
    var popoverIsPresented = false
    var actionSheetIsPresented = false
    var aninmate: Bool = false
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
    private (set) var sliderValue: Double = 0 {
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
    var addButtonIsVisible = false
    // MARK: - Functions
    private func findIndexForThis(dateType: DateType) -> Double { // for slider value
        guard let index = DateType.allCases.firstIndex(of: dateType) else { return .zero }
        return Double(index)
    }

    func updateFields() {
        title = event?.title ?? Constants.emptyString
        info = event?.info ?? Constants.emptyString
        date = event?.date ?? Date()
        color = event?.color ?? .gray
        dateType = event?.dateType ?? .day
        sliderValue = findIndexForThis(dateType: dateType)
    }

    func clearEvent() {
        event = nil
    }

    func createEvent(id: UUID?) -> Event {
        return Event(
            id: id ?? UUID(),
            title: title,
            info: info,
            date: date,
            dateType: dateType,
            color: color
        )
    }

    func buttonAction() {
        let event = createEvent(id: event?.id)
        if screenMode == .edit {
            RealmManager.editEvent(newEvent: event, completion: { [self] result in
                guard let alertManager = alertManager else { return }
                alertManager.getIdentifiebleErrorFrom(result: result)
            })
        } else {
            RealmManager.addEvent(event: event, completion: { [self] result in
                guard let alertManager = alertManager else { return }
                alertManager.getIdentifiebleErrorFrom(result: result)
            })
        }
    }

    func setScreenMode(mode: ScreenModeType) {
        screenMode = mode
    }

    func setEvent(event: Event) {
        self.event = event
    }

    func addHelpToTheButtonsBy(_ index: Int) -> String {
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

    func setAlertManager(alertManager: AlertManager) {
        self.alertManager = alertManager
    }
}

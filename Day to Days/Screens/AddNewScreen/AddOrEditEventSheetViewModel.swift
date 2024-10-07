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

    var popoverIsPresented = false
    var actionSheetIsPresented = false
    var aninmate: Bool = false
    private (set) var dragOffset = CGSize.zero
    // MARK: - User fields
    var title = Constants.emptyString {
        didSet {
            withAnimation {
                addButtonIsVisible = title.isEmpty ? false : true
            }
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

    private func addEvent(event: Event) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(event)
            }
        } catch {
            print("Adding error occurred: \(error.localizedDescription)")
        }
    }

    private func editEvent(newEvent: Event) {
        do {
            let realm = try Realm()
            if let eventToUpdate = realm.object(ofType: Event.self, forPrimaryKey: newEvent.id) {
                try realm.write {
                    eventToUpdate.title = newEvent.title
                    eventToUpdate.info = newEvent.info
                    eventToUpdate.date = newEvent.date
                    eventToUpdate.dateType = newEvent.dateType
                    eventToUpdate.color = newEvent.color
                }
            }
        } catch {
            print("Editing error occurred: \(error.localizedDescription)")
        }
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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let event = createEvent(id: event?.id)
            if screenMode == .edit {
                editEvent(newEvent: event)
            } else {
                addEvent(event: event)
            }
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
        withAnimation {
            sliderValue = Double(value)
        }
    }

    func setColor(color: Color) {
        withAnimation {
            self.color = color
        }
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

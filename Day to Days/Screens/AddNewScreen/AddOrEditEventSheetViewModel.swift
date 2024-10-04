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
    private var currentEvent: Event?
    private var fixedDate = Date()
    private var canDismiss = true
    private var event: Event?
    private (set) var addButtonIsVisible = false
    private (set) var buttonSpacer: ButtonSpacerType = .minimize
    var popoverIsPresented = false

    private (set) var sliderValue: Double = 0 {
        didSet {
            dateType = .allCases[Int(sliderValue)]
        }
    }
    // MARK: - Calculated properties
    var sheetTitle: String {
        screenMode == .edit ? "edit_event".localized: "new_event".localized
    }
    private let helpStrings = [
        "day_help", "week_help", "month_help", "year_help", "days_help"
    ]
    // MARK: - User fields
    var title: String = "" {
            didSet {
                protectedChangeOfCanDismiss()
                addButtonIsVisible = title.isEmpty ? false : true
        }
    }
    var info = "" {
        didSet {
            protectedChangeOfCanDismiss()
        }
    }
    var date = Date() {
        didSet {
            protectedChangeOfCanDismiss()
        }
    }
    private (set) var color = Color.gray {
        didSet {
            protectedChangeOfCanDismiss()
        }
    }
    var dateType: DateType = .day {
        didSet {
            protectedChangeOfCanDismiss()
        }
    }
    // MARK: - Functions
    private func findIndexForThis(dateType: DateType) -> Double { // for slider value
        guard let index = DateType.allCases.firstIndex(of: dateType) else { return 0 }
        return Double(index)
    }

    private func protectedChangeOfCanDismiss() {
        guard screenMode != nil else { return }
        canDismiss = !areFieldsEmpty()
    }
    private func updateFieldsFrom(_ event: Event?) {
        title = event?.title ?? ""
        info = event?.info ?? ""
        date = event?.date ?? fixedDate
        color = event?.color ?? Color.gray
        dateType = event?.dateType ?? DateType.day
        sliderValue = findIndexForThis(dateType: dateType)
    }

    private func areFieldsEmpty() -> Bool {
        title != "" || info != "" || color != Color.gray || dateType != .day || date != fixedDate
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

    private func editEvent(oldEventID: UUID, newEvent: Event) {
        do {
            let realm = try Realm()
            if let eventToUpdate = realm.object(ofType: Event.self, forPrimaryKey: oldEventID) {
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

    func setButtonSpacer(buttonSpacer: ButtonSpacerType) {
        self.buttonSpacer = buttonSpacer
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

    func extractEventData() {
        DispatchQueue.main.async {
            let eventToUpdate = self.currentEvent ?? self.event
            self.updateFieldsFrom(eventToUpdate)
        }
    }

    func dismissAlertPrepare(action: @escaping () -> Void) {
        DispatchQueue.main.async {
            let oldEventID = self.event?.id
            guard !self.canDismiss else { return }
            let event = self.createEvent(id: oldEventID)
            self.event = event
            action()
        }
    }

    func buttonAction() {
        DispatchQueue.main.async {
            let oldEventID = self.event?.id
            let event = self.createEvent(id: nil)
            if let oldEventID = oldEventID {
                self.editEvent(oldEventID: oldEventID, newEvent: event)
            } else {
                self.addEvent(event: event)
            }
            self.makeCurrentEventNil()
        }
    }

    func setScreenMode(mode: ScreenModeType) {
        screenMode = mode
    }

    func setEvent(event: Event) {
        self.event = event
    }

    func makeCurrentEventNil() {
        screenMode = nil
        currentEvent = nil
        canDismiss = true
        event = nil
    }

    func addHelpToTheButtonsBy(_ index: Int) -> String {
        return index < helpStrings.count ? helpStrings[index] : helpStrings.last!
    }

    func setSliderValue(value: Double) {
        withAnimation {
            sliderValue = Double(value)
        }
    }

    func toggleIsPresented() {
        popoverIsPresented.toggle()
    }

    func setColor(color: Color) {
        self.color = color
    }

    func setPopoverIsPresented(set: Bool) {
        popoverIsPresented = set
    }

    func getColorForMenuItem(currentColor: ColorType) -> Color {
        color.getColorType == currentColor ? Color.secondary : Color.clear
    }
}

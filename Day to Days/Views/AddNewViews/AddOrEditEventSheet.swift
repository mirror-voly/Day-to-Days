//
//  AddNewOrEditEventSheetView.swift
//  Day to Days
//
//  Created by mix on 04.09.2024.
//

import SwiftUI
import Combine

struct AddOrEditEventSheet: View {

    @Environment(DataStore.self) private var dataStore
    @State private var fieldsAreNotEmpy = false
    @State private var addButtonIsVisible = false
    @State private var canDismiss = true
    @State private var sliderValue: Double = 0
    @State private var buttonSpacer: CGFloat = 0
    @State private var title = ""
    @State private var info = ""
    @State private var date = Constants.fixedDate
    @State private var color = Color.gray
    @State private var dateType: DateType = .day
    @Binding var isOpened: Bool
    @Binding var showAlert: Bool

    var event: Event?

    var sheetTitle: String {
        dataStore.screenMode == .edit ? "edit_event".localized: "new_event".localized
    }

    // MARK: - Functions
    private func createEvent(id: UUID?) -> Event {
        guard let id = id else {
            return Event(title: title, info: info, date: date, dateType: dateType, color: color)
        }
        return Event(id: id, title: title, info: info, date: date, dateType: dateType, color: color)
    }

    private func extractEventData() {
        if let event = event {
            updateFieldsFrom(event)
        }

        if let currentEvent = dataStore.currentEvent {
            updateFieldsFrom(currentEvent)
        }
    }

    private func updateFieldsFrom(_ event: Event) {
        title = event.title
        info = event.info
        date = event.date
        color = event.color
        dateType = event.dateType
    }

    private func closeSheet() {
        canDismiss = true
        isOpened = false
    }

    private func dismissAlertPrepare(oldEventID: UUID?) {
        guard !canDismiss else { return }
        let event = createEvent(id: oldEventID)
        dataStore.setCurrentEvent(event: event)
        showAlert = true
    }

    private func buttonAction(oldEventID: UUID?) {
        let createdEvent = createEvent(id: nil)
        if let oldEventID = oldEventID {
            dataStore.editEvent(oldEventID: oldEventID, newEvent: createdEvent)
        } else {
            dataStore.addEvent(event: createdEvent)
        }
        dataStore.makeCurrentEventNil()
    }

    private func isFieldsAreNotEmpty() -> Bool {
        if title != "" || info != "" || color != Color.gray || dateType != .day || date != Constants.fixedDate {
            return true
        } else {
            return false
        }
    }

    // MARK: - View
    var body: some View {
        VStack(content: {
            GroupBox(sheetTitle) {
                AddEventFields(title: $title, description: $info, date: $date, color: $color)
                DateTypeSlider(sliderValue: $sliderValue, dateType: $dateType, sliderColor: $color)
                    .onTapGesture(perform: {
                        hideKeyboard()
                    })
            }
            Spacer()
            AddEventButton(onAddNew: {
                buttonAction(oldEventID: event?.id)
                closeSheet()
            }, addButtonIsVisible: $addButtonIsVisible)
            .frame(height: buttonSpacer)
            .tint(color)
        })
        .padding()

        // MARK: - View actions
        .onAppear(perform: { extractEventData() })
        .onChange(of: title) {
            fieldsAreNotEmpy = isFieldsAreNotEmpty()
            addButtonIsVisible = title.isEmpty ? false : true
        }
        .onChange(of: info) { fieldsAreNotEmpy = isFieldsAreNotEmpty() }
        .onChange(of: color) { fieldsAreNotEmpy = isFieldsAreNotEmpty() }
        .onChange(of: dateType) { fieldsAreNotEmpy = isFieldsAreNotEmpty() }
        .onChange(of: date) { fieldsAreNotEmpy = isFieldsAreNotEmpty() }
        .onChange(of: fieldsAreNotEmpy) { canDismiss = !fieldsAreNotEmpy }
        .onDisappear(perform: { dismissAlertPrepare(oldEventID: event?.id) })
        // MARK: Keyboard detection
        .onReceive(Publishers.keyboardWillShow) { _ in
            buttonSpacer = Constants.Сonstraints.buttonSpaсerMaximize
        }
        .onReceive(Publishers.keyboardWillHide) { _ in
            buttonSpacer = Constants.Сonstraints.buttonSpaсerMinimize
        }
    }
}

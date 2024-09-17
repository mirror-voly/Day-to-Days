//
//  AddNewOrEditEventSheetView.swift
//  Day to Days
//
//  Created by mix on 04.09.2024.
//

import SwiftUI
import Combine

struct AddOrEditEventSheet: View {

    @Environment(AddOrEditEventSheetViewModel.self) private var sheetViewModel
    @State private var title = ""
    @State private var info = ""
    @State private var date = Date()
    @State private var color = Color.gray
    @State private var dateType: DateType = .day

    @Binding var isOpened: Bool
    @Binding var showAlert: Bool
    var event: Event?

    private func updateFieldsFrom(_ event: Event?) {
        guard let event = event else { return }
        title = event.title
        info = event.info
        date = event.date
        color = event.color
        dateType = event.dateType
    }

    private func extractEventData() {
        if let currentEvent = sheetViewModel.currentEvent {
            updateFieldsFrom(currentEvent)
        } else {
            updateFieldsFrom(event)
        }
    }

    private func closeSheet() {
        sheetViewModel.canDismiss = true
        isOpened = false
    }

    private func createEvent(id: UUID?) -> Event {
        guard let id = id else {
            return Event(title: title, info: info, date: date, dateType: dateType, color: color)
        }
        return Event(id: id, title: title, info: info, date: date, dateType: dateType, color: color)
    }

    private func isFieldsAreNotEmpty() -> Bool {
        if title != "" || info != "" || color != Color.gray || dateType != .day || date != date {
            return true
        } else {
            return false
        }
    }

    private func dismissAlertPrepare(oldEventID: UUID?) {
        guard !sheetViewModel.canDismiss else { return }
        let event = createEvent(id: oldEventID)
        sheetViewModel.setCurrentEvent(event: event)
        showAlert = true
    }
    // MARK: - View
    var body: some View {
        VStack(content: {
            GroupBox(sheetViewModel.sheetTitle) {
                AddEventFields(title: $title, description: $info, date: $date, color: $color)
                DateTypeSlider(dateType: $dateType, sliderColor: $color)
                    .onTapGesture(perform: {
                        hideKeyboard()
                    })
            }
            Spacer()
            AddEventButton(onAddNew: {
                sheetViewModel.buttonAction(oldEventID: event?.id, event: createEvent(id: nil))
                closeSheet()
            })
            .frame(height: sheetViewModel.buttonSpacer)
            .tint(color)
        })
        .padding()

        // MARK: - View actions
        .onAppear(perform: { extractEventData() })
        .onChange(of: title) {
            sheetViewModel.fieldsAreNotEmpy = isFieldsAreNotEmpty()
            sheetViewModel.addButtonIsVisible = title.isEmpty ? false : true
        }
        .onChange(of: info) { sheetViewModel.fieldsAreNotEmpy = isFieldsAreNotEmpty() }
        .onChange(of: color) { sheetViewModel.fieldsAreNotEmpy = isFieldsAreNotEmpty() }
        .onChange(of: dateType) { sheetViewModel.fieldsAreNotEmpy = isFieldsAreNotEmpty() }
        .onChange(of: date) { sheetViewModel.fieldsAreNotEmpy = isFieldsAreNotEmpty() }
        .onChange(of: sheetViewModel.fieldsAreNotEmpy) { sheetViewModel.canDismiss = !sheetViewModel.fieldsAreNotEmpy }
        .onDisappear(perform: { dismissAlertPrepare(oldEventID: event?.id) })
        // MARK: Keyboard detection
        .onReceive(Publishers.keyboardWillShow) { _ in
            sheetViewModel.buttonSpacer = Сonstraints.buttonSpaсerMaximize
        }
        .onReceive(Publishers.keyboardWillHide) { _ in
            sheetViewModel.buttonSpacer = Сonstraints.buttonSpaсerMinimize
        }
    }
}

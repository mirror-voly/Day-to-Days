//
//  AddNewOrEditEventSheetView.swift
//  Day to Days
//
//  Created by mix on 04.09.2024.
//

import SwiftUI
import Combine

struct AddOrEditEventSheet: View {
    enum Constants {
        static let buttonSpaserMinimize: Int = 50
        static let buttonSpaserMaximize: Int = 130
        static let fixedDate = Date()
    }
    @Environment(DataStore.self) private var dataStore
    @State private var fieldsAreNotEmpy = false
    @State private var canDismiss = true
    @State private var sliderValue: Int = 0
    @State private var buttonSpaser: Int = 0

    @Binding var isOpened: Bool
    @Binding var showAlert: Bool

    @State private var title = ""
    @State private var description = ""
    @State private var date = Constants.fixedDate
    @State private var color = Color.gray
    @State private var dateType: Event.DateType = .day

    // MARK: - Functions
    private func createEvent() -> Event {
        return Event(title: title, description: description, date: date, dateType: dateType, color: color)
    }

    private func extractEventData() {
        guard let event = dataStore.currentEvent else { return }
        title = event.title
        description = event.description
        date = event.date
        color = event.color
    }

    private func closeSheet() {
        canDismiss = true
        isOpened = false
    }

    private func prepareForDismiss() {
        if !canDismiss {
            if dataStore.screenMode == .edit {
                guard let id = dataStore.currentEvent?.id else { return }
                dataStore.currentEvent = Event(id: id, title: title, description: description, date: date, dateType: dateType, color: color)
            } else {
                dataStore.currentEvent = createEvent()
            }
            showAlert = true
        }
    }

    private func buttonAction() {
        if dataStore.screenMode == .edit {
            dataStore.editEvent(newEvent: createEvent())
        } else {
            dataStore.addEvent(event: createEvent())
        }
        dataStore.currentEvent = nil
    }

    private func isFieldsAreNotEmpty() -> Bool {
        if title != "" || description != "" || color != Color.gray || dateType != .day || date != Constants.fixedDate {
            return true
        } else {
            return false
        }
    }

    // MARK: - View
    var body: some View {
        let sheetTitle = dataStore.screenMode == .edit ? "Edit Event": "New Event"
        VStack(content: {
            GroupBox(sheetTitle) {
                // MARK: Text group boxes
                GroupBox {
                    TextField(text: $title) {
                        Text("Title")
                    }
                    Divider()
                    TextField(text: $description) {
                        Text("Description")
                    }
                }
                .padding(.bottom)
                .onTapGesture(perform: {
                    hideKeyboard()
                })
                // MARK: Date and color pickers
                GroupBox {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    Divider()
                    ColorPicker("Color", selection: $color)
                }
                .padding(.bottom)
                // MARK: Date type slider
                DateTypeSlider(sliderValue: $sliderValue, dateType: $dateType)
                    .onTapGesture(perform: {
                        hideKeyboard()
                    })
            }
            Spacer()
            VStack(content: {
                Button(action: {
                    buttonAction()
                    closeSheet()
                }, label: {
                        Text("Done")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .frame(height: CGFloat(Constants.buttonSpaserMinimize))
                })
                .disabled(!fieldsAreNotEmpy)
                .buttonStyle(BorderedProminentButtonStyle())
                Spacer()
            })
            .frame(height: CGFloat(buttonSpaser))
        })
        .padding()

        // MARK: - View actions
        .onAppear(perform: {
            extractEventData()
        })
        .onChange(of: title) {
            fieldsAreNotEmpy = isFieldsAreNotEmpty()
        }
        .onChange(of: description) {
            fieldsAreNotEmpy = isFieldsAreNotEmpty()
        }
        .onChange(of: color) {
            fieldsAreNotEmpy = isFieldsAreNotEmpty()
        }
        .onChange(of: dateType) {
            fieldsAreNotEmpy = isFieldsAreNotEmpty()
        }
        .onChange(of: date) {
            fieldsAreNotEmpy = isFieldsAreNotEmpty()
        }
        .onChange(of: fieldsAreNotEmpy) {
            canDismiss = !fieldsAreNotEmpy
        }
        .onDisappear(perform: {
            prepareForDismiss()
        })
        // MARK: - Keyboard detection
        .onReceive(Publishers.keyboardWillShow) { _ in
            buttonSpaser = Constants.buttonSpaserMaximize
        }
        .onReceive(Publishers.keyboardWillHide) { _ in
            buttonSpaser = Constants.buttonSpaserMinimize
        }
    }
}

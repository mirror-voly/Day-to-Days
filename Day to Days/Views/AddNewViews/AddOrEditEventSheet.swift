//
//  AddNewOrEditEventSheetView.swift
//  Day to Days
//
//  Created by mix on 04.09.2024.
//

import SwiftUI

struct AddOrEditEventSheet: View {
    @Environment(DataStore.self) private var dataStore
    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()
    @State private var color = Color(.gray)
    @State private var titleSet = false
    @State private var sliderValue: Int = 0
    @State private var dateType: Event.DateType = .day
    @State var canDismiss = true
    @Binding var isOpened: Bool
    @Binding var showAlert: Bool

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

    // MARK: - View
    var body: some View {
        let sheetTitle = dataStore.screenMode == .edit ? "Edit Event": "New Event"
        VStack(content: {
            GroupBox(sheetTitle) {
                // MARK: - Text group boxes
                GroupBox {
                    TextField(text: $title) {
                        Text("Title")
                    }
                    Divider()
                    .onChange(of: title) {
                        titleSet = title != "" ? true : false
                    }
                    .onChange(of: titleSet) {
                        // TODO: canDismiss should react to all fields
                        canDismiss = !titleSet
                    }
                    TextField(text: $description) {
                        Text("Description")
                    }
                }
                .onAppear(perform: {
                    extractEventData()
                })
                .padding(.bottom)
                .onTapGesture(perform: {
                    hideKeyboard()
                })
                // MARK: - Date and color pickers
                GroupBox {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    Divider()
                    ColorPicker("Color", selection: $color)
                }
                .padding(.bottom)
                // MARK: - Date type slider
                DateTypeSlider(sliderValue: $sliderValue, dateType: $dateType)
            }
            Spacer()
            Button(action: {
                if dataStore.screenMode == .edit {
                    dataStore.editEvent(newEvent: createEvent())
                } else {
                    dataStore.addEvent(event: createEvent())
                }
                dataStore.currentEvent = nil
                closeSheet()
            }, label: {
                Text("Done")
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
            })
            .disabled(!titleSet)
            .buttonStyle(BorderedProminentButtonStyle())
        })
        .padding()
        .onDisappear(perform: {
            if !canDismiss {
                if dataStore.screenMode == .edit {
                    guard let id = dataStore.currentEvent?.id else { return }
                    dataStore.currentEvent = Event(id: id, title: title, description: description, date: date, dateType: dateType, color: color)
                } else {
                    dataStore.currentEvent = createEvent()
                }
                showAlert = true
            }
        })
    }
}

//#Preview {
//    AddOrEditEventSheet( isOpened: .constant(true), canDismiss: .constant(true), event: Event(title: "", description: "", date: Date(), dateType: .day, color: .blue), isEditMode: true)
//}

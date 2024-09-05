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
    @Binding var isOpened: Bool
    @Binding var canDismiss: Bool
    var event: Event?
    let isEditMode: Bool

    // MARK: - Functions
    private func createEvent() -> Event {
        return Event(title: title, description: description, date: date, dateType: dateType, color: color)
    }

    private func isEventNotNill() {
        guard let event = event else { return }
        dataStore.editEvent(oldEvent: event, newEvent: createEvent())
    }

    private func extractEventData() {
        guard let event = event else { return }
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
        let sheetTitle = isEditMode ? "Edit Event": "New Event"
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
                        canDismiss = !titleSet
                    }
                    TextField(text: $description) {
                        Text("Description")
                    }
                }
                .onAppear(perform: {
                    if isEditMode { extractEventData() }
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
                if isEditMode {
                    isEventNotNill()
                } else {
                    dataStore.addEvent(event: createEvent())
                }
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
    }
}

#Preview {
    AddOrEditEventSheet( isOpened: .constant(true), canDismiss: .constant(true), event: Event(title: "", description: "", date: Date(), dateType: .day, color: .blue), isEditMode: true)
}

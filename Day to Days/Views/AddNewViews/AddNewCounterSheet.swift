//
//  AddNewCounterSheet.swift
//  Day to Days
//
//  Created by mix on 04.09.2024.
//

import SwiftUI

struct AddNewCounterSheet: View {
    @Environment(DataStore.self) private var dataStore
    @State var title = ""
    @State var description = ""
    @State var date = Date()
    @State var color = Color(.white)
    @State var titleSet = false
    @State var sliderValue: Int = 0
    @State var dateType: Event.DateType = .day
    @Binding var sheetIsOpened: Bool
    @Binding var canDismiss: Bool
    private func makeNewEvent() -> Event {
        let event = Event(title: title, description: description, date: date, dateType: dateType, color: color)
        return event
    }
    private func addEvent() {
        dataStore.allEvents.append(makeNewEvent())
    }
    var body: some View {
        VStack(content: {
            GroupBox("New Event") {
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
                .padding(.bottom)
                .onTapGesture(perform: {
                    hideKeyboard()
                })
                GroupBox {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    Divider()
                    ColorPicker("Color", selection: $color)
                }
                .padding(.bottom)
                DateTypeSlider(sliderValue: $sliderValue, dateType: $dateType)
            }
            Spacer()
            Button(action: {
                addEvent()
                canDismiss = true
                sheetIsOpened = false
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
    AddNewCounterSheet( sheetIsOpened: .constant(true), canDismiss: .constant(true))
}

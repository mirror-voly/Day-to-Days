//
//  AddEventFields.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct AddEventFields: View {
    @Environment(DataStore.self) private var dataStore
    @Binding var title: String
    @Binding var description: String
    @Binding var date: Date
    @Binding var color: Color

    var body: some View {
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
            // MARK: Date and color pickers
            GroupBox {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.compact)
                Divider()
                ColorPicker("Color", selection: $color)
            }
            .padding(.bottom)
    }
}

//
//  AddEventFields.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct AddEventFields: View {
    @Environment(DataStore.self) private var dataStore
    @State private var popoverIsPresented = false
    @Binding var title: String
    @Binding var description: String
    @Binding var date: Date
    @Binding var color: Color

    var body: some View {
            GroupBox {
                TextField(text: $title) {
                    Text("title".localized)
                }
                Divider()
                TextField(text: $description) {
                    Text("description".localized)
                }
            }
            .padding(.bottom)
            // MARK: Date and color pickers
            GroupBox {
                DatePicker("date".localized, selection: $date, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .contextMenu {
                        HelpContextMenu(helpText: "date_help")
                    }
                Divider()
                ColorPickerPopover(popoverIsPresented: $popoverIsPresented, color: $color)
            }
            .padding(.bottom)
    }
}

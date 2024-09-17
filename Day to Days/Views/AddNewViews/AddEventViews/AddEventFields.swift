//
//  AddEventFields.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct AddEventFields: View {

    @Environment(AddOrEditEventSheetViewModel.self) private var sheetViewModel
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
                HStack {
                    DatePicker("date".localized, selection: $date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .contextMenu {
                            HelpContextMenu(helpText: "date_help")
                        }
                    Button {
                        date = Date()
                    } label: {
                        Image(systemName: "pin.circle.fill")
                            .tint(.primary)
                            .symbolRenderingMode(.hierarchical)
                            .font(.system(size: 20))
                    }
                    .contextMenu {
                        HelpContextMenu(helpText: "date_reset_help")
                    }
                }
                Divider()
                ColorPickerPopover(color: $color)
            }
            .padding(.bottom)
    }
}

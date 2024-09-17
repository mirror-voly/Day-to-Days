//
//  AddEventFields.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct AddEventFields: View {

    @Environment(AddOrEditEventSheetViewModel.self) private var sheetViewModel
//    @Binding var title: String
//    @Binding var description: String
//    @Binding var date: Date
//    @Binding var color: Color

    var body: some View {
            GroupBox {
                TextField(text: Binding(get: {
                    sheetViewModel.title
                }, set: { value in
                    sheetViewModel.title = value
                })) {
                    Text("title".localized)
                }
                Divider()
                TextField(text: Binding(get: {
                    sheetViewModel.info
                }, set: { value in
                    sheetViewModel.info = value
                })) {
                    Text("description".localized)
                }
            }
            .padding(.bottom)
            // MARK: Date and color pickers
            GroupBox {
                HStack {
                    DatePicker("date".localized, selection: Binding(get: {
                        sheetViewModel.date
                    }, set: { value in
                        sheetViewModel.date = value
                    }), displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .contextMenu {
                            HelpContextMenu(helpText: "date_help")
                        }
                    Button {
                        sheetViewModel.date = Date()
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
                ColorPickerPopover()
            }
            .padding(.bottom)
    }
}

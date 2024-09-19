//
//  AddEventFields.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct AddEventFields: View {
    @Environment(AddOrEditEventSheetViewModel.self) private var viewModel

    var body: some View {
            GroupBox {
                TextField(text: Binding(get: {
                    viewModel.title
                }, set: { value in
                    viewModel.title = value
                })) {
                    Text("title".localized)
                }
                Divider()
                TextField(text: Binding(get: {
                    viewModel.info
                }, set: { value in
                    viewModel.info = value
                })) {
                    Text("description".localized)
                }
            }
            .padding(.bottom)
            // MARK: Date and color pickers
            GroupBox {
                HStack {
                    DatePicker("date".localized, selection: Binding(get: {
                        viewModel.date
                    }, set: { value in
                        viewModel.date = value
                    }), displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .contextMenu {
                            HelpContextMenu(helpText: "date_help")
                        }
                    Button {
                        viewModel.date = Date()
                    } label: {
                        Image(systemName: "pin.circle.fill")
                            .tint(.primary)
                            .symbolRenderingMode(.hierarchical)
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

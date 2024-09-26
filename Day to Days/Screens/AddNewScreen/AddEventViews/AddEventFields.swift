//
//  AddEventFields.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct AddEventFields: View {
    @Bindable var viewModel: AddOrEditEventSheetViewModel
    var body: some View {
        GroupBox {
            ClearableTextField(text: $viewModel.title, placeholder: "title")
            Divider()
            ClearableTextField(text: $viewModel.info, placeholder: "description")
        }
            .padding(.bottom)
            // MARK: Date and color pickers
            GroupBox {
                HStack {
                    DatePicker("date".localized, selection: $viewModel.date, displayedComponents: .date)
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
                ColorPickerPopover(viewModel: viewModel)
            }
            .padding(.bottom)
    }
}

struct ClearableTextField: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack {
            TextField(placeholder.localized, text: $text)
            if !text.isEmpty {
                Button {
                    text.removeAll()
                } label: {
                    Image(systemName: "clear")
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

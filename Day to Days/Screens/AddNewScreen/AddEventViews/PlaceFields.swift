//
//  AddEventFields.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct PlaceFields: View {
    @Bindable var viewModel: AddOrEditEventSheetViewModel
    var body: some View {
        GroupBox {
            ClearableTextField(text: $viewModel.title, placeholder: "title")
                .animation(.linear, value: viewModel.addButtonIsVisible)
            Divider()
            ClearableTextField(text: $viewModel.info, placeholder: "description")
                .animation(.linear, value: viewModel.info.isEmpty)
        }
        // MARK: Date and color pickers
        GroupBox {
            HStack {
                DatePicker("date".localized, selection: $viewModel.date, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .contextMenu {
                        HelpContextMenu(helpText: "date_help")
                    }
                    .contentTransition(.numericText())
                Button {
                    withAnimation {
                        viewModel.date = Date()
                        viewModel.aninmateDateButton.toggle()
                    }
                } label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                        .tint(.primary)
                        .symbolRenderingMode(.hierarchical)
                        .font(.title2)
                        .rotationEffect(Angle(degrees: viewModel.aninmateDateButton ?
                                              Constraints.rotationAngle : .zero))
                }
                .contextMenu {
                    HelpContextMenu(helpText: "date_reset_help")
                }
            }
            Divider()
            ColorPicker(viewModel: viewModel)
        }
        GroupBox {
            DateTypeSlider()
        }
    }
}

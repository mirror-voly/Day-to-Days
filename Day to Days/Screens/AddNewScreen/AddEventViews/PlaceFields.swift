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
		// MARK: Text fiewlds
        GroupBox {
            ClearableTextField(text: $viewModel.title, placeholder: "title")
                .animation(.linear, value: viewModel.addButtonIsVisible)
            Divider()
            ClearableTextField(text: $viewModel.info, placeholder: "description")
                .animation(.linear, value: viewModel.info.isEmpty)
        }
		// MARK: Photo picker
		GroupBox {
			PhotoPickerView(viewModel: viewModel)
		}
        // MARK: Date and color pickers
        GroupBox {
			DatePickerView(viewModel: viewModel)
            Divider()
            ColorPicker(viewModel: viewModel)
        }
        GroupBox {
            DateTypeSlider()
        }
    }
}

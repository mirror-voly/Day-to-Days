//
//  PhotoPickerView.swift
//  Day to Days
//
//  Created by mix on 18.10.2024.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
	@Bindable var viewModel: AddOrEditEventSheetViewModel
    var body: some View {
		HStack { 
			Text("select_an_image".localized)
			Spacer()
			if viewModel.photoItemIsNotEmpty {
				Button { 
					withAnimation { 
						viewModel.photoItem = nil
					}
				} label: { 
					Image(systemName: "clear")
						.tint(.secondary)
						.symbolRenderingMode(.hierarchical)
				}
				.padding(.horizontal)
			}
			PhotosPicker(selection: $viewModel.photoItem, matching: .images, label: {
				Image(systemName: viewModel.photoItemIsNotEmpty ? "photo.badge.checkmark" : "photo")
					.tint(viewModel.photoItemIsNotEmpty ? viewModel.color : .secondary)
					.symbolRenderingMode(.hierarchical)
			})
		}
    }
}

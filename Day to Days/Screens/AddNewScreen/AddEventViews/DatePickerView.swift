//
//  DatePickerView.swift
//  Day to Days
//
//  Created by mix on 21.10.2024.
//

import SwiftUI

struct DatePickerView: View {
	@Bindable var viewModel: AddOrEditEventSheetViewModel
	
    var body: some View {
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
    }
}

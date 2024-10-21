//
//  DateRowsView.swift
//  Day to Days
//
//  Created by mix on 21.10.2024.
//

import SwiftUI

struct DateRowsView: View {
	@Environment(EventInfoScreenViewModel.self) private var viewModel
	
    var body: some View {
		GroupBox {
			Text(viewModel.localizedTimeState)
				.font(.subheadline)
			Divider()
			ForEach(viewModel.allDateTypes, id: \.self) { dateTypeKey in
				if let number = viewModel.allInfoForCurrentDate?[dateTypeKey] {
					DateInfoView(number: number, dateType: dateTypeKey, viewModel: viewModel)
				}
			}
		}
		.frame(width: Constraints.eventDateTableSize)
		.shadow(color: .secondary, radius: 1)
    }
}

#Preview {
    DateRowsView()
}

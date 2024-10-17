//
//  AddOrEditEventSheet.swift
//  Day to Days
//
//  Created by mix on 04.09.2024.
//

import SwiftUI
import Combine

struct AddOrEditEventSheet: View {
	@State private var viewModel: AddOrEditEventSheetViewModel
    @Binding var isOpened: Bool
    // MARK: - View
    var body: some View {
        VStack(content: {
            GroupBox {
                HeaderView(isOpened: $isOpened)
                PlaceFields(viewModel: viewModel)
            }
            .padding()
            Spacer()
        })
        // MARK: - ActionSheet guesture
        .offset(y: viewModel.dragOffset.height)
        .gesture(DragGesture()
            .onChanged({ value in
                viewModel.dragOffsetForSheetFrom(value)
            })
        )
        // MARK: - ActionSheet
        .confirmationDialog(Constants.emptyString,
                            isPresented: $viewModel.actionSheetIsPresented,
                            actions: {
            Button(role: .destructive, action: {
                isOpened = false
            }, label: {
                Text("сontinue".localized)
            })
        })
        .environment(viewModel)
    }

    init(event: Event? = nil, isOpened: Binding<Bool>, screenMode: ScreenModeType, notificationManager: NotificationManager) {
        self._isOpened = isOpened
		self.viewModel = AddOrEditEventSheetViewModel(notificationManager: notificationManager)
        viewModel.setScreenMode(mode: screenMode)
        viewModel.updateFieldsFrom(event)
    }
}

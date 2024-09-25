//
//  AddOrEditEventSheet.swift
//  Day to Days
//
//  Created by mix on 04.09.2024.
//

import SwiftUI
import Combine

struct AddOrEditEventSheet: View {
    private let viewModel: AddOrEditEventSheetViewModel
    @Binding var isOpened: Bool
    @Binding var showAlert: Bool

    // MARK: - View
    var body: some View {
        VStack(content: {
            GroupBox(viewModel.sheetTitle) {
                AddEventFields(viewModel: viewModel)
                DateTypeSlider()
                    .onTapGesture(perform: {
                        hideKeyboard()
                    })
            }
            Spacer()
            AddEventButton(onAddNew: {
                viewModel.buttonAction()
                isOpened = false
            })
            .frame(height: viewModel.buttonSpacer.value)
            .tint(viewModel.color)
        })
        .padding()

        // MARK: - View actions
        .onAppear(perform: { viewModel.extractEventData() })
        .onDisappear(perform: { viewModel.dismissAlertPrepare(action: {
            showAlert = true
        })
        })
        // MARK: Keyboard detection
        .onReceive(Publishers.keyboardWillShow) { _ in
            viewModel.setButtonSpacer(buttonSpacer: .maximize)
        }
        .onReceive(Publishers.keyboardWillHide) { _ in
            viewModel.setButtonSpacer(buttonSpacer: .minimize)
        }
    }
    init(event: Event, isOpened: Binding<Bool>, showAlert: Binding<Bool>, viewModel: AddOrEditEventSheetViewModel) {
        self._isOpened = isOpened
        self._showAlert = showAlert
        self.viewModel = viewModel
        viewModel.setEvent(event: event)
    }

    init(isOpened: Binding<Bool>, showAlert: Binding<Bool>, viewModel: AddOrEditEventSheetViewModel) {
        self._isOpened = isOpened
        self._showAlert = showAlert
        self.viewModel = viewModel
    }
}

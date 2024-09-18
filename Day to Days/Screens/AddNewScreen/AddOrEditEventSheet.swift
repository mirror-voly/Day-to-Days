//
//  AddOrEditEventSheet.swift
//  Day to Days
//
//  Created by mix on 04.09.2024.
//

import SwiftUI
import Combine

struct AddOrEditEventSheet: View {
    @Environment(AddOrEditEventSheetViewModel.self) private var viewModel
    @Binding var isOpened: Bool
    @Binding var showAlert: Bool
    var event: Event?

    // MARK: - View
    var body: some View {
        VStack(content: {
            GroupBox(viewModel.sheetTitle) {
                AddEventFields()
                DateTypeSlider()
                    .onTapGesture(perform: {
                        hideKeyboard()
                    })
            }
            Spacer()
            AddEventButton(onAddNew: {
                viewModel.buttonAction(oldEventID: event?.id, event: viewModel.createEvent(id: nil))
                isOpened = false
            })
            .frame(height: viewModel.buttonSpacer.value)
            .tint(viewModel.color)
        })
        .padding()

        // MARK: - View actions
        .onAppear(perform: { viewModel.extractEventData(event: event) })
        .onDisappear(perform: { 
            viewModel.dismissAlertPrepare(oldEventID: event?.id, action: {
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
}

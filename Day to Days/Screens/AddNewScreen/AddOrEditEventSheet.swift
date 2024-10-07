//
//  AddOrEditEventSheet.swift
//  Day to Days
//
//  Created by mix on 04.09.2024.
//

import SwiftUI
import Combine

struct AddOrEditEventSheet: View {
    @Bindable private var viewModel: AddOrEditEventSheetViewModel
    @Binding var isOpened: Bool
    // MARK: - View
    var body: some View {
        VStack(content: {
            GroupBox {
                HStack {
                    Text(viewModel.sheetTitle)
                    Spacer()
                    Button(action: {
                        viewModel.buttonAction()
                        isOpened = false
                    }, label: {
                        Text("done".localized)
                    })
                    .disabled(!viewModel.addButtonIsVisible)
                    .opacity(viewModel.addButtonIsVisible ? Constraints.originalSize :
                                Constraints.scaleColorItem)
                    .tint(viewModel.color)
                    .buttonStyle(BorderedButtonStyle())
                    .foregroundStyle(.primary)
                    .contextMenu {
                        if !viewModel.addButtonIsVisible {
                            HelpContextMenu(helpText: "add_button_help")
                        }
                    }
                }
                AddEventFields(viewModel: viewModel)
            }
            Spacer()
        })
        .padding()
        .onAppear(perform: { viewModel.updateFields() })
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
    }

    init(event: Event, isOpened: Binding<Bool>,
         viewModel: AddOrEditEventSheetViewModel) {
        self._isOpened = isOpened
        self.viewModel = viewModel
        viewModel.setEvent(event: event)
    }

    init(isOpened: Binding<Bool>,
         viewModel: AddOrEditEventSheetViewModel) {
        self._isOpened = isOpened
        self.viewModel = viewModel
        viewModel.clearEvent()
    }
}

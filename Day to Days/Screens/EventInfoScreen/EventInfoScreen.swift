//
//  EventInfoScreen.swift
//  Day to Days
//
//  Created by mix on 06.09.2024.
//

import SwiftUI
import RealmSwift

struct EventInfoScreen: View {
    @Environment(AddOrEditEventSheetViewModel.self) private var sheetViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = EventInfoScreenViewModel()
    @State var event: Event

    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, content: {
            GroupBox {
                HStack(alignment: .top, content: {
                    VStack(alignment: .leading, content: {
                        Text(event.date.formatted(date: .long, time: .omitted))
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .padding(.bottom)
                        Text(event.info.isEmpty ? "no_description".localized : event.info)
                    })
                    Spacer()
                    // MARK: Date presenter
                    GroupBox {
                        Text(viewModel.localizedTimeState?.capitalized ?? "")
                            .font(.subheadline)
                        Divider()
                        LazyVStack {
                            ForEach(viewModel.allDateTypes, id: \.self) { dateType in
                                if let value = viewModel.allInfoForCurrentDate?[dateType] {
                                    DateInfoView(value: value, label: TimeUnitLocalizer.localizeIt(for: value, unit: dateType.label))
                                }
                            }
                        }
                    }
                    .frame(width: Сonstraints.eventDateTableSize)
                })
            }
            Spacer()
        })
        .padding()
        // MARK: - View settings
        .navigationTitle(event.title)
        .toolbarBackground(event.color, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden()
        .onAppear(perform: {
            viewModel.onAppearActions(event: event)
        })
        .onChange(of: event, { _, _ in
            viewModel.onAppearActions(event: event)
        })
        .sheet(isPresented: $viewModel.sheetIsOpened, onDismiss: {
            self.event = viewModel.updateEditedEvent(eventID: event.id) ?? self.event
        }, content: {
            AddOrEditEventSheet(isOpened: $viewModel.sheetIsOpened, showAlert: $viewModel.alertIsPresented, event: event)
        })
        .alert(isPresented: $viewModel.alertIsPresented, content: {
            NewAlert.showAlert {
                sheetViewModel.makeCurrentEventNil()
            } onCancel: {
                viewModel.sheetIsOpened = true
            }
        })
        .toolbar(content: {
            backButton
            editButton
        })
        .tint(event.color)
    }
}

extension EventInfoScreen {
    private var backButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                dismiss()
            } label: {
                Circle()
                    .fill(.white)
                    .frame(width: Сonstraints.eventInfoButtonSize, height: Сonstraints.eventInfoButtonSize)
                    .overlay(Image(systemName: "chevron.backward")
                        .fontWeight(.semibold))
            }
        }
    }

    private var editButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                sheetViewModel.setScreenMode(mode: .edit)
                viewModel.sheetIsOpened = true
            } label: {
                Circle()
                    .fill(.white)
                    .frame(width: Сonstraints.eventInfoButtonSize, height: Сonstraints.eventInfoButtonSize)
                    .overlay(Image(systemName: "pencil")
                        .fontWeight(.semibold))
            }
            .contextMenu {
                HelpContextMenu(helpText: "edit_event")
            }
        }
    }
}

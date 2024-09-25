//
//  EventInfoScreen.swift
//  Day to Days
//
//  Created by mix on 06.09.2024.
//

import SwiftUI
import RealmSwift

struct EventInfoScreen: View {
    @Environment(AddOrEditEventSheetViewModel.self) var sheetViewModel
    @Environment(\.dismiss) var dismiss
    @Bindable var viewModel: EventInfoScreenViewModel
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, content: {
            GroupBox {
                HStack(alignment: .top, content: {
                    VStack(alignment: .leading, content: {
                        Text(viewModel.event.date.formatted(date: .long, time: .omitted))
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .padding(.bottom)
                        Text(viewModel.info)
                    })
                    Spacer()
                    // MARK: Date presenter
                    GroupBox {
                        Text(viewModel.localizedTimeState?.capitalized ?? "")
                            .font(.subheadline)
                        Divider()
                        VStack {
                            ForEach(viewModel.allDateTypes, id: \.self) { dateTypeKey in
                                if let value = viewModel.allInfoForCurrentDate?[dateTypeKey] {
                                    DateInfoView(value: value,
                                                 label: TimeUnitLocalizer.localizeIt(for: value,
                                                                                     unit: dateTypeKey.label))
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
        .navigationTitle(viewModel.event.title)
        .toolbarBackground(viewModel.event.color, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $viewModel.sheetIsOpened, onDismiss: {
            viewModel.setEvent(event: viewModel.updateEditedEvent(eventID: viewModel.event.id) ?? self.viewModel.event)
            viewModel.onAppearActions(event: viewModel.event)
        }, content: {
            AddOrEditEventSheet(event: viewModel.event, 
            isOpened: $viewModel.sheetIsOpened,
            showAlert: $viewModel.alertIsPresented, viewModel: sheetViewModel)
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
            widgetButton
            editButton
        })
        .tint(viewModel.event.color)
    }

    init(event: Event) {
        self.viewModel = EventInfoScreenViewModel()
        viewModel.setEvent(event: event)
    }
}

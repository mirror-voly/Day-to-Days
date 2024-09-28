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
                        Text(viewModel.event.title)
                            .font(.title2)
                        Text(viewModel.event.date.formatted(date: .long, time: .omitted))
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .padding(.bottom)
                        Text(viewModel.info)
                    })
                    Spacer()
                    // MARK: Date presenter
                    GroupBox {
                        Text(viewModel.localizedTimeState)
                            .font(.subheadline)
                        Divider()
                        ForEach(viewModel.allDateTypes, id: \.self) { dateTypeKey in
                            if let number = viewModel.allInfoForCurrentDate?[dateTypeKey] {
                                DateInfoView(number: number, dateType: dateTypeKey)
                            }
                        }
                    }
                    .frame(width: Constraints.eventDateTableSize)
                })
            }
            Spacer()
        })
        .padding()
        // MARK: - View settings
        .navigationTitle("details".localized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(viewModel.event.color, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $viewModel.sheetIsOpened, onDismiss: {
            viewModel.updateEditedEvent()
        }, content: {
            AddOrEditEventSheet(event: viewModel.event, isOpened: $viewModel.sheetIsOpened,
            showAlert: $viewModel.alertIsPresented, viewModel: sheetViewModel)
        })
        .alert(isPresented: $viewModel.alertIsPresented, content: {
            NewAlert.showAlert {
                sheetViewModel.makeCurrentEventNil()
            } onCancel: {
                viewModel.reopenSheet()
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
        self.viewModel = EventInfoScreenViewModel(event: event)
    }
}

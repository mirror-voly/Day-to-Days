//
//  EventInfoScreen.swift
//  Day to Days
//
//  Created by mix on 06.09.2024.
//

import SwiftUI
import RealmSwift

struct EventInfoScreen: View {
    @ObservedResults(Event.self) var allEvents
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
                        Divider()
                            .frame(width: Constraints.dividerWidth)
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
                                DateInfoView(number: number, dateType: dateTypeKey, viewModel: viewModel)
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
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(viewModel.event.color, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $viewModel.sheetIsOpened, onDismiss: {
            withAnimation {
                viewModel.updateEditedEvent()
            }
            WidgetManager.sendToWidgetsThis(Array(allEvents))
        }, content: {
            AddOrEditEventSheet(event: viewModel.event,
                                isOpened: $viewModel.sheetIsOpened,
                                viewModel: sheetViewModel)
            .interactiveDismissDisabled()
        })
        .toolbar(content: {
            backButton
            editButton
        })
        .tint(viewModel.event.color)
    }

    init(event: Event) {
        self.viewModel = EventInfoScreenViewModel(event: event)
    }
}

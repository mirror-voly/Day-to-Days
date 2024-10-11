//
//  EventInfoScreen.swift
//  Day to Days
//
//  Created by mix on 06.09.2024.
//

import SwiftUI
import RealmSwift

struct EventInfoScreen: View {
    @ObservedResults(Event.self) private var allEvents
    @Environment(\.dismiss) var dismiss
    @Environment(AlertManager.self) private var alertManager
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
        .toolbarBackground(viewModel.event.color, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $viewModel.sheetIsOpened, onDismiss: {
            withAnimation {
                viewModel.updateEditedEvent(completion: { result in
                    alertManager.getIdentifiebleErrorFrom(result: result)
                })
            }
            WidgetManager.sendToWidgetsThis(Array(allEvents), completion: { result in
                alertManager.getIdentifiebleErrorFrom(result: result)
            })
        }, content: {
            AddOrEditEventSheet(event: viewModel.event,
                                isOpened: $viewModel.sheetIsOpened,
                                screenMode: .edit)
            .interactiveDismissDisabled()
        })
        .toolbar(content: {
            backButton
            notificationSettingsButton
            editButton
        })
        .tint(viewModel.event.color)
    }

    init(event: Event) {
        self.viewModel = EventInfoScreenViewModel(event: event)
    }
}

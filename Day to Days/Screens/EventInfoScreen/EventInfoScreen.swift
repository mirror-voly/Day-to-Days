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
    @State var viewModel = EventInfoScreenViewModel()
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

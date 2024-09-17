//
//  EventInfoScreen.swift
//  Day to Days
//
//  Created by mix on 06.09.2024.
//

import SwiftUI
import RealmSwift

struct EventInfoScreen: View {
    @Environment(MainScreenViewModel.self) private var dataStore
    @Environment(AddOrEditEventSheetViewModel.self) private var sheetViewModel
    @Environment(\.dismiss) private var dismis
    @State private var sheetIsOpened = false
    @State private var alertIsPresented = false
    @State var event: Event
    private let allDateTypes = (DateType.allCases).reversed()
    private var info: String {
        event.info.isEmpty ? "no_description".localized : event.info
    }
    private var currentDateAllInfo: [DateType: String] {
        DateCalculator.dateInfoForThis(date: event.date, dateType: event.dateType)
    }
    private func updateEditedEvent() {
        guard let finded = dataStore.findEventBy(id: event.id) else { return }
        self.event = finded
    }
    // MARK: - View
    var body: some View {
        // TODO: Need refactoring
        let dateNumber = DateCalculator.findFirstDateFromTheTopFor(date: event.date, dateType: event.dateType)
        let timeState = DateCalculator.determineFutureOrPastForThis(date: event.date)
        let localizetTimeState = TimeUnitLocalizer.localizeTimeState(for: dateNumber, state: timeState, dateType: event.dateType)
        VStack(alignment: .leading, content: {
            GroupBox {
                HStack(alignment: .top, content: {
                    VStack(alignment: .leading, content: {
                        Text(event.date.formatted(date: .long, time: .omitted))
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .padding(.bottom)
                        Text(info)
                    })
                    Spacer()
                    // MARK: Date presenter
                    GroupBox {
                        Text(localizetTimeState.capitalized)
                            .font(.subheadline)
                        Divider()
                        LazyVStack {
                            ForEach(allDateTypes, id: \.self) { dateType in
                                if let value = currentDateAllInfo[dateType] {
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
        .sheet(isPresented: $sheetIsOpened, onDismiss: {
            updateEditedEvent()
        }, content: {
            AddOrEditEventSheet(isOpened: $sheetIsOpened, showAlert: $alertIsPresented, event: event)
        })
        .alert(isPresented: $alertIsPresented, content: {
            NewAlert.showAlert {
                sheetViewModel.makeCurrentEventNil()
            } onCancel: {
                sheetIsOpened = true
            }
        })
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismis()
                }
            label: {
                Circle()
                    .fill(.white)
                    .frame(width: Сonstraints.eventInfoButtonSize, height: Сonstraints.eventInfoButtonSize)
                    .overlay(Image(systemName: "chevron.backward")
                        .fontWeight(.semibold))
            }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    sheetViewModel.setScreenMode(mode: .edit)
                    sheetIsOpened = true
                }
            label: {
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
        })
        .tint(event.color)
    }
}

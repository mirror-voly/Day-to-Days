//
//  EventInfoScreen.swift
//  Day to Days
//
//  Created by mix on 06.09.2024.
//

import SwiftUI

struct EventInfoScreen: View {
    @State var event: Event
    @State private var sheetIsOpened = false
    @State private var alertIsPresented = false
    @Environment(DataStore.self) private var dataStore
    @Environment(\.dismiss) private var dismis
    private let circleButtonSize = Constants.Сonstraints.eventInfoButtonSize
    private let allDateTypes = (DateType.allCases).reversed()

    private var description: String {
        event.info.isEmpty ? "No description" : event.info
    }

    private var currentDateAllInfo: [DateType: String] {
        DateCalculator.dateInfoForThis(date: event.date, dateType: event.dateType)
    }

    private func updateEditedEvent() {
        guard let editedEvent = dataStore.editedEvent else { return }
        self.event = editedEvent
    }
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
                        Text(description)
                    })
                    Spacer()
                    // MARK: Date presenter
                    GroupBox {
                        LazyVStack {
                            ForEach(allDateTypes, id: \.self) { dateType in
                                if let value = currentDateAllInfo[dateType] {
                                    DateInfoView(value: value, label: dateType.label)
                                }
                            }
                        }
                        Divider()
                        Text(DateCalculator.determineFutureOrPastForThis(event.date))
                            .font(.subheadline)
                    }
                    .frame(width: Constants.Сonstraints.eventDateTableSize)
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
            AddOrEditEventSheet(isOpened: $sheetIsOpened,
                                showAlert: $alertIsPresented)
        })
        .alert(isPresented: $alertIsPresented, content: {
            NewAlert.showAlert {
                dataStore.makeCurrentEventNil()
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
                    .frame(width: circleButtonSize, height: circleButtonSize)
                    .overlay(Image(systemName: "chevron.backward")
                        .fontWeight(.semibold))
            }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dataStore.setScreenMode(mode: .edit)
                    dataStore.setCurrentEvent(event: event)
                    sheetIsOpened = true
                }
            label: {
                Circle()
                    .fill(.white)
                    .frame(width: circleButtonSize, height: circleButtonSize)
                    .overlay(Image(systemName: "pencil")
                        .fontWeight(.semibold))
            }
            }
        })
        .tint(event.color)
        .onDisappear {
            dataStore.makeEditedEventNil()
        }
    }
}

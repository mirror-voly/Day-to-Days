//
//  EventInfoScreen.swift
//  Day to Days
//
//  Created by mix on 06.09.2024.
//

import SwiftUI

struct EventInfoScreen: View {
    @State var event: Event
    @State var sheetIsOpened = false
    @State var alertIsPresented = false
    @Environment(DataStore.self) private var dataStore
    @Environment(\.dismiss) private var dismis
    private let circleButtonSize = Constants.Сonstraints.eventInfoButtonSize

    private func setEditedEvent() {
        guard let editedEvent = dataStore.editedEvent else { return }
        self.event = editedEvent
    }

    var body: some View {
        VStack(alignment: .leading, content: {
            GroupBox {
                HStack(alignment: .top, content: {
                    VStack(alignment: .leading, content: {
                        Text(event.date.formatted(date: .long, time: .omitted))
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .padding(.bottom)
                        let description = event.description == "" ? "No description": event.description
                        Text(description)
                    })
                    Spacer()
                    GroupBox {
                        // TODO: add weaks, months, yars
                        Text(DateCalculator.daysFrom(thisDate: event.date).days)
                            .font(.title)
                            .bold()
                        Text("days")
                    }
                })
            }
            Spacer()
        })
        .padding()
        .navigationTitle(event.title)
        .toolbarBackground(event.color, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $sheetIsOpened, onDismiss: {
            setEditedEvent()
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
                ZStack(alignment: .center, content: {
                    Circle()
                        .fill(.white)
                        .frame(width: circleButtonSize, height: circleButtonSize)
                    Image(systemName: "chevron.backward")
                        .fontWeight(.semibold)
                })
            }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dataStore.setScreenMode(mode: .edit)
                    dataStore.setCurrentEvent(event: event)
                    sheetIsOpened = true
                }
            label: {
                ZStack(alignment: .center, content: {
                    Circle()
                        .fill(.white)
                        .frame(width: circleButtonSize, height: circleButtonSize)
                    Image(systemName: "pencil")
                        .fontWeight(.semibold)
                })
            }
            }
        })
        .tint(event.color)
        .onDisappear {
            dataStore.makeEditedEventNil()
        }
    }
}

#Preview {
    EventInfoScreen(event: Event.dummy)
}

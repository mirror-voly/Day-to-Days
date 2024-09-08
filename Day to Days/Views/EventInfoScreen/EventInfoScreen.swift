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
    let circleButtonSize = Constants.Сonstraints.eventInfoButtonSize

    var body: some View {
        Divider()
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
        .sheet(isPresented: $sheetIsOpened, onDismiss: {
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
                    dataStore.screenMode = .edit
                    dataStore.currentEvent = event
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
    }
}

#Preview {
    EventInfoScreen(event: Event.dummy)
}

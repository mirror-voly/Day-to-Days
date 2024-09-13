//
//  EventsItemView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct EventsItemView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(DataStore.self) private var dataStore
    @Binding var editMode: EditMode
    @State private var isSelected = false
    let event: Event
    private let circleHoleSize = Constants.Сonstraints.eventsItemViewCicleHoleSize
    private let circleSize = Constants.Сonstraints.eventsItemViewCicleSize
    private let bigCircleSize = Constants.Сonstraints.eventsItemViewBigCicleSize
    private let dateFrameSize = Constants.Сonstraints.eventsItemViewDateFrameSize
    private let scaleFactor = Constants.Сonstraints.eventsItemViewDateTextMinimumScaleFactor

    private func toggleSelection() {
        if !isSelected {
            isSelected = true
            dataStore.insertToSelectedEvents(eventID: event.id)
        } else {
            isSelected = false
            dataStore.removeFromSelectedEvents(eventID: event.id)
        }
    }

    var body: some View {
        // TODO: Need refactoring
        let timeState = DateCalculator.determineFutureOrPastForThis(date: event.date)
        let dateNumber = DateCalculator.findFirstDateFromTheTopFor(date: event.date, dateType: event.dateType)
        let localizetDateType = TimeUnitLocalizer.localizeIt(for: dateNumber, unit: event.dateType.label)
        let localizetTimeState = TimeUnitLocalizer.localizeTimeState(for: dateNumber, state: timeState, dateType: event.dateType)
        HStack {
            // MARK: - Circle
                ZStack(alignment: .center, content: {

//                    if isSelected {
//                        Image(systemName: "minus.circle.fill")
//                            .foregroundStyle(.red)
//                            .font(.system(size: circleSize))
//                    }
                        Circle()
                        .fill(event.color)
                            .overlay(
                                Circle()
                                    .fill(colorScheme == .light ? .white : .black)
                                .frame(width: circleHoleSize, height: circleHoleSize))

                    Button {
                        if editMode == .active {
                            print("taped")
                                toggleSelection()
                        }
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundStyle(.red)
                            .font(.system(size: circleSize))
                    }
                })
                .frame(width: circleSize)
                .padding()
//                .onTapGesture {
//                    if editMode == .active {
//                        print("taped")
//                            toggleSelection()
//                    }
//                }
                .onChange(of: editMode) { _, newValue in
                    if newValue != .active {
                        isSelected = false
                    }
                }
            // MARK: - Title
                Text(event.title)
                    .font(.title2)
            Spacer()
            // MARK: - Day counter
                            VStack {
                                Text(localizetTimeState.capitalized)
                                Divider()
                                Text(dateNumber)
                                    .foregroundStyle(event.color)
                                    .bold()
                                    .font(.title3)
                                    .frame(maxWidth: .infinity)
                                    .minimumScaleFactor(scaleFactor)
                                    .lineLimit(1)
                                Text(timeState != .present ? localizetDateType : "")
                                    .italic()
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                            .frame(width: dateFrameSize)
                            .padding()
        }
        .containerShape(Rectangle())
        .overlay(alignment: .center) {
            if isSelected {
                Rectangle()
                    .fill(Color.black.gradient.opacity(0.1))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipShape(.rect(cornerRadius: 20))
            }
        }

    }
}

//
//  EventsItemView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct EventsItemView: View {
    @Environment(\.colorScheme) var colorScheme
    let event: Event
    private let circleHoleSize = Constants.Сonstraints.eventsItemViewCicleHoleSize
    private let circleSize = Constants.Сonstraints.eventsItemViewCicleSize
    private let bigCircleSize = Constants.Сonstraints.eventsItemViewBigCicleSize
    private let dateFrameSize = Constants.Сonstraints.eventsItemViewDateFrameSize
    private let scaleFactor = Constants.Сonstraints.eventsItemViewDateTextMinimumScaleFactor

    var body: some View {
        // TODO: Need refactoring
        let timeState = DateCalculator.determineFutureOrPastForThis(date: event.date)
        let dateNumber = DateCalculator.findFirstDateFromTheTopFor(date: event.date, dateType: event.dateType)
        let localizetDateType = TimeUnitLocalizer.localizeIt(for: dateNumber, unit: event.dateType.label)
        let localizetTimeState = TimeUnitLocalizer.localizeTimeState(for: dateNumber, state: timeState, dateType: event.dateType)
        HStack {
            // MARK: - Circle
            ZStack(alignment: .center, content: {
                    Circle()
                    .fill(event.color)
                        .overlay(
                            Circle()
                                .fill(colorScheme == .light ? .white : .black)
                            .frame(width: circleHoleSize, height: circleHoleSize))
            })
            .frame(width: circleSize)
            .padding()
            // MARK: - Title
                Text(event.title)
                    .font(.title2)
            Spacer()
            // MARK: - Day counter
            GroupBox {
                    GroupBox {
                        ZStack(alignment: .center, content: {
                            Circle()
                                .fill(Color.white)
                                .frame(width: bigCircleSize, height: bigCircleSize)

                            VStack {
                                Text(dateNumber)
                                    .foregroundStyle(event.color)
                                    .bold()
                                    .font(.title3)
                                    .frame(maxWidth: .infinity)
                                    .minimumScaleFactor(scaleFactor)
                                    .lineLimit(1)
                            }
                            .frame(maxWidth: .infinity)
                        })
                        .frame(width: dateFrameSize, height: dateFrameSize)
                    }
                    Group {
                        Text(timeState != .present ? localizetDateType : "")
                        Text(localizetTimeState)
                    }
                    .italic()
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
        }
        .containerShape(Rectangle())
    }
}

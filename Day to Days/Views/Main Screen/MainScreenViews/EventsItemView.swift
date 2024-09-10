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
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                    GroupBox {
                        ZStack(alignment: .center, content: {
                            Circle()
                                .fill(Color.white)
                                .frame(width: bigCircleSize, height: bigCircleSize)

                                        VStack {
                                            Text(DateCalculator.findFirstDateFromTheTopFor(date: event.date, dateType: event.dateType))
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
                        Text(event.dateType.label)
                        Text(DateCalculator.determineFutureOrPastForThis(event.date))
                    }
                    .italic()
                    .font(.footnote)
                    .foregroundStyle(.gray)
                })
            }
        }
        .containerShape(Rectangle())
    }
}

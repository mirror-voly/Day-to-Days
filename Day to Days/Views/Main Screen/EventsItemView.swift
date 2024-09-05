//
//  EventsItemView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct EventsItemView: View {
    let day: Event
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        let haloColor: Color = colorScheme == .light ? .white : .black
        HStack {
            // MARK: - Circle Zstack
            ZStack(alignment: .center, content: {
                Circle()
                    .fill(Color.white.opacity(0.5))
                    .frame(width: 22, height: 22)
                    Circle()
                        .fill(day.color)
                        .overlay(
                            Circle()
                            .fill(haloColor)
                            .frame(width: 20, height: 15))
                        .frame(width: 20, height: 20)
            })
            .frame(width: 25)
            .padding()
            // MARK: - Title
                Text(day.title)
                    .font(.title2)
            Spacer()
            // MARK: - Day counter
            GroupBox {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                    let dateData = DateCalculator.daysFrom(thisDate: day.date)
                    GroupBox {
                        ZStack(alignment: .center, content: {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 50, height: 50)
                            Text(dateData.days)
                                .foregroundStyle(day.color)
                                .bold()
                                .font(.title3)
                                .frame(width: 40)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        })
                        .frame(width: 40, height: 40)
                    }
                    Group {
                        // TODO: add weaks, months, yars
                        Text("days")
                        Text(dateData.description)
                    }
                    .italic()
                    .font(.footnote)
                    .foregroundStyle(.gray)
                })
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .containerShape(Rectangle())
    }
}

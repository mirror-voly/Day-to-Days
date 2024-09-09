//
//  EventsItemView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct EventsItemView: View {
    let event: Event
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack {
            // MARK: - Circle
            ZStack(alignment: .center, content: {
                    Circle()
                    .fill(event.color)
                        .overlay(
                            Circle()
                                .fill(colorScheme == .light ? .white : .black)
                            .frame(width: 20, height: 11))
            })
            .frame(width: 25)
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
                                .frame(width: 50, height: 50)
                            Text(String(DateCalculator.daysFrom(date: event.date)))
                                .foregroundStyle(event.color)
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
                        Text(DateCalculator.determineFutureOrPast(this: event.date))
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
#Preview {
    EventsItemView(event: .dummy)
}

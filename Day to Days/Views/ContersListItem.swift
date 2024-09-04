//
//  ContersListItem.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct ContersListItem: View {
    let day: Day
    let dateCalculator = DateCalculator()
    var body: some View {
        HStack {
            Circle()
                .fill(day.color)
                .overlay(Circle()
                    .fill(day.color)
                    .frame(width: 20, height: 10))
                .opacity(0.6)
                .frame(width: 20, height: 20)
            Text(day.title)
                .font(.title2)
            Spacer()
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                let dateData = dateCalculator.daysFrom(thisDate: day.date)
                Text(dateData.days)
                    .foregroundStyle(day.color)
                    .bold()
                Group {
                    Text("days")
                    Text(dateData.description)
                }
                .italic()
                .font(.footnote)
                .foregroundStyle(.gray)
            })
        }
    }
}

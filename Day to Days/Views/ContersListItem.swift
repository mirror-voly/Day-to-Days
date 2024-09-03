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
                .frame(width: 20, height: 20)
            Text(day.title)
            Spacer()
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                Text(dateCalculator.daysFrom(thisDate: day.date))
                Text("days")
                Text("gone")
            })
        }
    }
}

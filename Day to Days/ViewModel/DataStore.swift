//
//  DataStore.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import Foundation
let isoFormatter = ISO8601DateFormatter()
final class DataStore {
    let listOfDays: [Day] = [Day(date: isoFormatter.date(from: "2025-03-15T14:30:00Z")!, title: "My first try", color: .red),
                             Day(date: isoFormatter.date(from: "2024-03-11T14:30:00Z")!, title: "Meeting", color: .teal),
                             Day(date: Date(), title: "Guitar trin", color: .black),
                             Day(date: isoFormatter.date(from: "2023-03-16T14:30:00Z")!, title: "Paiment for rent", color: .purple),
                             Day(date: isoFormatter.date(from: "2022-03-15T14:30:00Z")!, title: "Shooping", color: .blue),
                             Day(date: isoFormatter.date(from: "2022-02-15T14:30:00Z")!, title: "Alcohol", color: .gray),
                             Day(date: isoFormatter.date(from: "2023-12-15T14:30:00Z")!, title: "Car driving", color: .mint),
                             Day(date: isoFormatter.date(from: "2023-03-15T14:30:00Z")!, title: "Walk on the street sdfsd gsdfgsdf s   gsdfgs dfgsf sdfg sdf gf gfg fd fgd gdtr t r tr", color: .green),
                             Day(date: isoFormatter.date(from: "2022-03-01T14:30:00Z")!, title: "Madee some stuff", color: .indigo),
                             Day(date: isoFormatter.date(from: "2023-04-15T14:30:00Z")!, title: "Drink coffe", color: .yellow),
                             Day(date: isoFormatter.date(from: "2023-05-15T14:30:00Z")!, title: "Yoga", color: .purple),
                             Day(date: isoFormatter.date(from: "2023-03-15T14:30:00Z")!, title: "Eat chchos", color: .cyan),
                             Day(date: isoFormatter.date(from: "2023-07-15T14:30:00Z")!, title: "Realy good morning", color: .brown),
                             Day(date: isoFormatter.date(from: "2023-11-15T14:30:00Z")!, title: "Watched TV", color: .accentColor)]
}

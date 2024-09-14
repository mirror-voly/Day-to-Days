//
//  SortRelults.swift
//  Day to Days
//
//  Created by mix on 14.09.2024.
//

import Foundation
import RealmSwift

final class SortRelults {
    static func sortResulsBy(allEvents: Results<Event>, sortBy: SortType, ascending: Bool) -> [Event] {
        allEvents.sorted {
            switch sortBy {
            case .date:
                let lhs = $0[keyPath: \Event.date] as Date
                let rhs = $1[keyPath: \Event.date] as Date
                return ascending ? lhs < rhs : lhs > rhs
            case .title:
                let lhs = $0[keyPath: \Event.title] as String
                let rhs = $1[keyPath: \Event.title] as String
                return ascending ? lhs < rhs : lhs > rhs
            default:
                return true
            }
        }
    }
}

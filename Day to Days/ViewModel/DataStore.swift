//
//  DataStore.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//
import RealmSwift
import SwiftUI

@Observable
final class DataStore {

    enum EditModeType {
        case edit
        case add
    }
    // MARK: - Private variables
    private (set) var screenMode: EditModeType?
    private (set) var currentEvent: Event?
    var selectedState: [UUID: Bool] = [:]
    var events: Results<Event>?
    private (set) var noSelectedEvents = true
    var navigationLinkIsPresented = false
    var editMode: EditMode = .inactive
    var ascending = true
    var sortBy: SortType = .none
    let fixedDate = Date()

    let primaryOpacity = Сonstraints.primaryOpacity
    
    let circleHoleSize = Сonstraints.eventsItemViewCicleHoleSize
    let circleSize = Сonstraints.eventsItemViewCicleSize
    let bigCircleSize = Сonstraints.eventsItemViewBigCicleSize
    let dateFrameSize = Сonstraints.eventsItemViewDateFrameSize
    let scaleFactor = Сonstraints.dateTextMinimumScaleFactor
    let cornerRadius = Сonstraints.cornerRadius

    var sortedEvents: [Event] {
        guard let events = events else { return []}
        let result: [Event] = sortResulsBy(allEvents: events, sortBy: sortBy, ascending: ascending).reversed()
        return result
    }

    private var selectedEvents: Set<UUID> = [] {
           didSet {
               noSelectedEvents = selectedEvents.isEmpty
           }
       }

    func allTimeDataFor(event: Event) -> [String: String] {
        let timeState = DateCalculator.determineFutureOrPastForThis(date: event.date)
        let dateNumber = DateCalculator.findFirstDateFromTheTopFor(date: event.date, dateType: event.dateType)
        let localizetDateType = TimeUnitLocalizer.localizeIt(for: dateNumber, unit: event.dateType.label)
        let localizedTimeState = TimeUnitLocalizer.localizeTimeState(for: dateNumber, state: timeState, dateType: event.dateType)
        return ["timeState": timeState.label, "dateNumber": dateNumber, "localizetDateType": localizetDateType, "localizedTimeState": localizedTimeState]
    }

    // MARK: TapGesture Actions
    func toggleSelectedState(eventID: UUID) {
        selectedState[eventID, default: false].toggle()
    }

    func toggleSelection(eventID: UUID, isSelected: Bool) {
        if isSelected {
            insertToSelectedEvents(eventID: eventID)
        } else {
            removeFromSelectedEvents(eventID: eventID)
        }
    }
    // MARK: - Functions for changing private variables
    func insertToSelectedEvents(eventID: UUID) {
        selectedEvents.insert(eventID)
    }

    func removeFromSelectedEvents(eventID: UUID) {
        selectedEvents.remove(eventID)
    }

    func makeSelectedEventsEmpty() {
        selectedEvents = []
    }

    func setCurrentEvent(event: Event) {
        currentEvent = event
    }

    func setScreenMode(mode: EditModeType) {
        screenMode = mode
    }

    func makeCurrentEventNil() {
        screenMode = nil
        currentEvent = nil
    }

    func removeSelectedEvents() {
        guard !noSelectedEvents else { return }
        for eventID in selectedEvents {
            do {
                let realm = try Realm()
                try realm.write {
                    if let eventToDelete = realm.object(ofType: Event.self, forPrimaryKey: eventID) {
                        realm.delete(eventToDelete)
                    }
                }
            } catch {
                print("Adding error occurred: \(error.localizedDescription)")
            }
        }
        makeSelectedEventsEmpty()
    }

    func addEvent(event: Event) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(event)
            }
        } catch {
            print("Adding error occurred: \(error.localizedDescription)")
        }
    }

    func findEventBy(id: UUID) -> Event? {
        do {
            let realm = try Realm()
            if let event = realm.object(ofType: Event.self, forPrimaryKey: id) {
                return event
            }
        } catch {
            print("Finding error occurred: \(error.localizedDescription)")
        }
        return nil
    }

    func editEvent(oldEventID: UUID, newEvent: Event) {
        do {
            let realm = try Realm()
            if let eventToUpdate = realm.object(ofType: Event.self, forPrimaryKey: oldEventID) {
                try realm.write {
                    eventToUpdate.title = newEvent.title
                    eventToUpdate.info = newEvent.info
                    eventToUpdate.date = newEvent.date
                    eventToUpdate.dateType = newEvent.dateType
                    eventToUpdate.color = newEvent.color
                }
            }
        } catch {
            print("Editing error occurred: \(error.localizedDescription)")
        }
    }

    func sortResulsBy(allEvents: Results<Event>, sortBy: SortType, ascending: Bool) -> [Event] {
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

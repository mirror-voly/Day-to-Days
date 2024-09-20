//
//  WidgetViewModel.swift
//  Day to Days
//
//  Created by mix on 20.09.2024.
////
//
//import SwiftUI
//
//@Observable
//final class WidgetViewModel {
//    private (set) var localizedTimeState: String = ""
//    private (set) var number: String = ""
//    private (set) var localizedDateType: String = ""
//
//    func setTimeData(event: Event) {
//        let timeData =  TimeUnitLocalizer.allTimeDataFor(event: event)
//        if let localizedTimeState = timeData["localizedTimeState"] {
//            self.localizedTimeState = localizedTimeState.capitalized
//        }
//        if let number = timeData["dateNumber"] {
//            self.number = number
//        }
//        if timeData["localizedDateType"] != nil {
//            if timeData ["timeState"] != TimeStateType.present.label {
//                self.localizedDateType = localizedTimeState
//            }
//        }
//    }
//}

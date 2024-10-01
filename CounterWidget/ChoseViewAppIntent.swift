//
//  ChoseViewAppIntent.swift
//  Day to Days
//
//  Created by mix on 01.10.2024.
//

import WidgetKit
import AppIntents

struct ChoseWidgetView: AppIntent {
    static var title: LocalizedStringResource = "Chose"
    
//    @Parameter(title: "eventID")
    var current: Int = 0
    
    func perform() async throws -> some IntentResult {
        .result()
    }
    
    
}

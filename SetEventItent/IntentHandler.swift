//
//  IntentHandler.swift
//  SetEventItent
//
//  Created by mix on 02.10.2024.
//

import Intents

class IntentHandler: INExtension, SetupEventIntentHandling {
    func provideWidgetEventOptionsCollection(for intent: SetupEventIntent, with completion: @escaping (INObjectCollection<WidgetEvent>?, (any Error)?) -> Void) {
        let collection: [WidgetEvent] = [WidgetEvent(identifier: "1", display: "2")]
        completion(INObjectCollection(items: collection), nil)
    }
    
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}

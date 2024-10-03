//
//  WidgetColorQuery.swift
//  CounterWidgetExtension
//
//  Created by mix on 22.09.2024.
//
//
//import WidgetKit
//import AppIntents
//
//struct WidgetColorQuery: EntityQuery {
//    func entities(for identifiers: [WidgetColor.ID]) async throws -> [WidgetColor] {
//        WidgetColor.allColors.filter{
//            identifiers.contains($0.id)
//        }
//    }
//
//    func suggestedEntities() async throws -> [WidgetColor] {
//        WidgetColor.allColors
//    }
//
//    func defaultResult() async -> WidgetColor? {
//        WidgetColor.allColors.first
//    }
//}

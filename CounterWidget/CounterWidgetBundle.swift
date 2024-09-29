//
//  CounterWidgetBundle.swift
//  CounterWidget
//
//  Created by mix on 20.09.2024.
//

import WidgetKit
import SwiftUI

@main
struct CounterWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        CounterWidget()
    }
}

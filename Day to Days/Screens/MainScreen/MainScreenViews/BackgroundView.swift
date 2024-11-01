//
//  BackgroundView.swift
//  Day to Days
//
//  Created by mix on 01.11.2024.
//

import SwiftUI

struct BackgroundView: View {
	
	var isPresented: Bool
	
    var body: some View {
		Group {
			Rectangle()
				.fill(.orange)
				.frame(width: 100, height: 1000)
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
				.rotationEffect(Angle(degrees: isPresented ? 0 : 45))
			Rectangle()
				.fill(.orange)
				.frame(width: 100, height: 1000)
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
				.rotationEffect(Angle(degrees: isPresented ? 0 : 135))
		}
		.allowsHitTesting(false)
		.opacity(isPresented ? 0.6 : 0.8)
    }
}

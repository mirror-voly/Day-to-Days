//
//  ImageOverlayView+zoomOverlayButtons.swift
//  Day to Days
//
//  Created by mix on 20.10.2024.
//

import SwiftUI

extension ImageOverlayView {
	var zoomOverlayButtons: some View {
		Group {
			VStack {
				Group {
					Button { 
						self.viewModel.scale = viewModel.scale * Constraints.scaleEffect
					} label: { 
						Text("+")
							.frame(maxWidth: .infinity, maxHeight: .infinity)
					}
					Button { 
						self.viewModel.scale = viewModel.scale / Constraints.scaleEffect
					} label: { 
						Text("-")	
							.frame(maxWidth: .infinity, maxHeight: .infinity)
					}
				}
				.frame(width: Constraints.buttonSize, height: Constraints.buttonSize)
				.buttonStyle(BorderedButtonStyle())
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
			.padding()
		}
	}
}

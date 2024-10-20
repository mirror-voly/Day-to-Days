//
//  ImageOverlayView.swift
//  Day to Days
//
//  Created by mix on 19.10.2024.
//

import SwiftUI

struct ImageOverlayView: View {
	@Environment(EventInfoScreenViewModel.self) var viewModel

	var body: some View {
		GeometryReader { proxy in
			if let image = viewModel.overlay {
				Color.black.opacity(Constraints.primaryOpacity)
					.ignoresSafeArea()
				ScrollView([.horizontal, .vertical]) {
					image
						.resizable()
						.scaledToFit()
						.scaleEffect(x: viewModel.scale, y: viewModel.scale)
						.frame(width: proxy.size.width * (pow(viewModel.scale, Constraints.scalePower)),
							   height: proxy.size.height * (pow(viewModel.scale, Constraints.scalePower)))
						.gesture(
							MagnificationGesture()
								.onChanged { value in
									self.viewModel.scale = viewModel.scale * value
								}
						)
						.onTapGesture {
							withAnimation { 
								self.viewModel.overlay = nil
								self.viewModel.toolBarVisibility = .visible
							}
						}
				}
				.defaultScrollAnchor(.center)
				.overlay(alignment: .bottomTrailing) {
					zoomOverlayButtons
				}
				.onAppear(perform: {
					viewModel.toolBarVisibility = .hidden
					self.viewModel.scale = Constraints.originalSize
				})
			}
		}		
	}
}

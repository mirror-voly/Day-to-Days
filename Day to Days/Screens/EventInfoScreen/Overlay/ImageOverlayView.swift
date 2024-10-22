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
								viewModel.closeOverlay()
							}
						}
				}
				.defaultScrollAnchor(.center)
				.overlay(alignment: .bottomTrailing) {
					if !viewModel.isImageForShare {
						zoomOverlayButtons
					} else {
						ShareLink(item: image, preview: SharePreview(viewModel.event.title, image: image))
							.frame(maxWidth: .infinity, alignment: .center)
					}
				}
				.onAppear(perform: {
					self.viewModel.scale = Constraints.originalSize
				})
			}
		}		
	}
}

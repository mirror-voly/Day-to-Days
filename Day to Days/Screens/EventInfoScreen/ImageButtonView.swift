//
//  ImageButtonView.swift
//  Day to Days
//
//  Created by mix on 20.10.2024.
//

import SwiftUI

struct ImageButtonView: View {
	@Environment(EventInfoScreenViewModel.self) private var viewModel
	
    var body: some View {
		if let image = viewModel.buttonImage {
				GroupBox {
					Button {
						withAnimation { 
							viewModel.setOverlayImage(image: nil, isImageForShare: false)
						}
					} label: { 
						image
							.resizable()
							.clipShape(RoundedRectangle(cornerRadius: Constraints.cornerRadius))
							.padding()
							.aspectRatio(contentMode: ContentMode.fit)
							.shadow(color: .black, radius: Constraints.shadowRadius, y: Constraints.shadowRadius)
					}
				}
		}
    }
}

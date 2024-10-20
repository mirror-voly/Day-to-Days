//
//  ImageButtonView.swift
//  Day to Days
//
//  Created by mix on 20.10.2024.
//

import SwiftUI

struct ImageButtonView: View {
	@Environment(EventInfoScreenViewModel.self) private var viewModel
	let imageData: Data
	
    var body: some View {
		if let uiImage = UIImage(data: imageData) {
			GroupBox {
				Button {
					withAnimation { 
						viewModel.overlay = Image(uiImage: uiImage)
					}
				} label: { 
					Image(uiImage: uiImage)
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

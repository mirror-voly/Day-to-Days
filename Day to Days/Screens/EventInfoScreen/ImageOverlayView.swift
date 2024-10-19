//
//  ImageOverlayView.swift
//  Day to Days
//
//  Created by mix on 19.10.2024.
//

import SwiftUI

struct ImageOverlayView: View {
	@Environment(EventInfoScreenViewModel.self) private var viewModel
	@State var scale: CGFloat = Constraints.originalSize
	var body: some View {
		GeometryReader { proxy in
			if let image = viewModel.overlay {
				Group {
					Color.black.opacity(Constraints.primaryOpacity)
					ScrollView([.horizontal, .vertical]) {
						image
							.resizable()
							.gesture(
								MagnificationGesture()
									.onChanged { value in
										self.scale = scale * value
									}
							)
							.onTapGesture {
								viewModel.overlay = nil
								viewModel.toolBarVisibility = .visible
							}
							.onAppear { 
								viewModel.toolBarVisibility = .hidden
							}
							.scaledToFit()
							.scaleEffect(x: scale, y: scale)
							.frame(width: proxy.size.width * (pow(scale, Constraints.scalePower)),
								   height: proxy.size.height * (pow(scale, Constraints.scalePower)))
					}
					.scrollTargetBehavior(.viewAligned)
					.scrollBounceBehavior(.always)
					.defaultScrollAnchor(.center)
					.onAppear(perform: { 
						self.scale = Constraints.originalSize
					})
				}
				.ignoresSafeArea()
				
				.overlay { 
					VStack { 
						Spacer()
						HStack {
							Spacer()
							VStack {
								Group {
									Button { 
										self.scale = scale * Constraints.scaleEffect
									} label: { 
										Text("+")
											.frame(maxWidth: .infinity, maxHeight: .infinity)
									}
									Button { 
										self.scale = scale / Constraints.scaleEffect
									} label: { 
										Text("-")	
											.frame(maxWidth: .infinity, maxHeight: .infinity)
									}
								}
								.frame(width: Constraints.buttonSize, height: Constraints.buttonSize)
								.buttonStyle(BorderedButtonStyle())
							}
						}
						.padding()
					}

				}
			}
		}
		
	}
}

#Preview {
    ImageOverlayView()
}

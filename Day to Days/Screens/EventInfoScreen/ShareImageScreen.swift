//
//  ShareImageScreen.swift
//  Day to Days
//
//  Created by mix on 21.10.2024.
//

import SwiftUI

struct ShareImageScreen: View {
	@Environment(EventInfoScreenViewModel.self) private var viewModel
	
    var body: some View {
		VStack {
			VStack(alignment: .leading) {
				GroupBox {
					Text(viewModel.event.title)
						.frame(maxWidth: .infinity)
				}
				Spacer()
					ZStack {
						HStack() {
							Text("Day\nto\nDays")
								.foregroundStyle(.black)
								.frame(maxHeight: .infinity)
								.fontWeight(.ultraLight)
							Spacer()
						}
						.padding(.horizontal, 6)
						Circle()
							.fill()
							.shadow(color: .colorScheme, radius: Constraints.shadowRadius)
						Image(systemName: "birthday.cake.fill")
							.font(.system(size: 50))
							.frame(maxWidth: .infinity)
							.multilineTextAlignment(.center)
							.foregroundStyle(.yellow.gradient)
					}
				GroupBox {
					ZStack(alignment: .topTrailing) {
						HStack {
							Text(viewModel.localizedTimeState)
								.padding(.vertical, 3)
								.padding(.horizontal)
						}
						.background(.colorScheme)
						.clipShape(.capsule)
						.padding(.top, -32)
						.padding(.trailing, -10)
						.shadow(color: .black, radius: 4)
						HStack {
							ForEach(viewModel.allDateTypes, id: \.self) { dateTypeKey in
								if let number = viewModel.allInfoForCurrentDate?[dateTypeKey] {
									VStack { 
										DateInfoView(number: number, dateType: dateTypeKey, viewModel: viewModel)
									}
								}
							}
						}
					}
					
				}
				.frame(maxWidth: .infinity)
			}
			.padding()
			.background(viewModel.event.color.gradient)
			.clipShape(RoundedRectangle(cornerRadius: Constraints.cornerRadius))
		}
		.frame(width: 300, height: 300)
    }
}

#Preview {
    ShareImageScreen()
}

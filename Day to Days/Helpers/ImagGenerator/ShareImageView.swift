//
//  ShareImageView.swift
//  Day to Days
//
//  Created by mix on 21.10.2024.
//

import SwiftUI

struct ShareImageView: View {
	
	let title: String 
	let localizedTimeState: String
	let dateTypes: ReversedCollection<[DateType]>
	let allInfoForCurrentDate: [DateType: String]
	let dateCalculator: DateCalculator
	let color: Color
	
	var body: some View {
		VStack {
			VStack(alignment: .leading) {
				Text(title)
					.foregroundStyle(.white)
					.multilineTextAlignment(.center)
					.frame(maxWidth: .infinity)
					.frame(height: Constraints.shareCentralInageFontSize)
					.padding(.horizontal)
					.background(.black.secondary)
					.shadow(color: .black, radius: Constraints.shadowRadius)
					.clipShape(.rect(cornerRadius: Constraints.cornerRadius))
				
				Spacer()
				
				ZStack {
					Circle()
						.fill(.white)
						.shadow(color: .black, radius: Constraints.shadowRadius)
					VStack(spacing: Constraints.originalSize) {
						Image(systemName: "birthday.cake.fill")
							.font(.system(size: Constraints.shareCentralInageFontSize))
							.frame(maxWidth: .infinity)
							.foregroundStyle(.yellow)
						Text(localizedTimeState)
							.foregroundStyle(.white)
							.font(.footnote)
							.bold()
							.padding(.horizontal, Constraints.shareHorizontalPadding)
							.background(.yellow)
							.clipShape(.capsule)
					}
					
					VStack(alignment: .leading) {
						Group {
							Text("Day")
							Text("to")
							Text("Days")
						}
						.foregroundStyle(.white)
						.fontWeight(.ultraLight)
					}
					.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
				}
				.frame(height: Constraints.shareCentralPartSize)
				.padding(.horizontal, Constraints.shareHorizontalPadding)
				
				Spacer()
				
				HStack(alignment: .center) {
					ForEach(dateTypes, id: \.self) { dateTypeKey in
						if let number = allInfoForCurrentDate[dateTypeKey] {
							VStack {
								DateInfoView(number: number, dateType: dateTypeKey,dateCalculator: dateCalculator)
									.foregroundStyle(.white)
							}
						}
					}
				}
				.frame(maxWidth: .infinity)
			}
			.padding()
			.background(color)
			.clipShape(RoundedRectangle(cornerRadius: Constraints.cornerRadius))
		}
		.frame(width: Constraints.renderedImageSize, height: Constraints.renderedImageSize)
	}
}

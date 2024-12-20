//
//  RenderImage.swift
//  Day to Days
//
//  Created by mix on 22.10.2024.
//

import SwiftUI

final class ImageGenerator {
	
	func makeImage(content: some View, completion: @escaping (Result<Image, Error>) -> Void){
		DispatchQueue.main.async {
			let renderer = ImageRenderer(content: content)
			renderer.scale = Constraints.renderScale
			if let image = renderer.cgImage {
				completion(.success(Image(decorative: image, scale: Constraints.renderScale)))
			}
		}

	}
}

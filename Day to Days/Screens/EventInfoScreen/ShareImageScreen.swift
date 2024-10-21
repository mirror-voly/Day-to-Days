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
		HStack { 
			
			DateRowsView()
		}
    }
}

#Preview {
    ShareImageScreen()
}

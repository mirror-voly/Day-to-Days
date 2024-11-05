//
//  SettingsScreen.swift
//  Day to Days
//
//  Created by mix on 03.11.2024.
//

import SwiftUI

struct SettingsScreen: View {
	
	@Environment(MainScreenViewModel.self) private var viewModel
	@Environment(AlertManager.self) var alertManager
	
    var body: some View {
		List {
			Group {
				HStack {
					Text("Sort list by")
					
					Spacer()
					
					Menu {
						ForEach(SortType.allCases, id: \.self) { sortType in
							Button(role: .cancel) {
								viewModel.sortButtonAction(type: sortType, completion: { result in
									alertManager.getIdentifiebleErrorFrom(result: result)
								})
							} label: {
								HStack {
									Text(sortType.rawValue.localized)
									Image(systemName: sortType != .none ? viewModel.imageSortIconReversed : "dot.circle")
								}
							}
						}
					} label: {
						HStack {
							Text(viewModel.sortBy.rawValue.capitalized)
							Image(systemName: viewModel.sortBy != .none ? viewModel.imageSortIcon : "dot.circle")
						}
					}
					.buttonStyle(.borderedProminent)
					.tint(.gray)
				}

				Button("Code on GitHub") {
					UIApplication.shared.open(Constants.url)
				}
				.bold()
			}
			.frame(height: 50)
		}
		.listRowBackground(BackgroundView(isPresented: false))
		.listRowSeparator(.visible, edges: .all)
		.listStyle(.insetGrouped)
    }
}

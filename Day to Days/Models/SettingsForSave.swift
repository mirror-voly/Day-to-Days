//
//  SettingsForSave.swift
//  Day to Days
//
//  Created by mix on 05.11.2024.
//

import Foundation

final class SettingsForSave: Codable {
	let sortType: SortType
	let ascending: Bool
	
	init(sortType: SortType, ascending: Bool) {
		self.sortType = sortType
		self.ascending = ascending
	}
}

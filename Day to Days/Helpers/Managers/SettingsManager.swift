//
//  SettingsManager.swift
//  Day to Days
//
//  Created by mix on 05.11.2024.
//

import Foundation

final class SettingsManager {
	func saveSettings(sortType: SortType, ascending: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
		let settings = SettingsForSave(sortType: sortType, ascending: ascending)
		do {
			let data = try JSONEncoder().encode(settings)
			if let userDefaults = UserDefaults(suiteName: Constants.suiteName) {
				userDefaults.set(data, forKey: Constants.settingsStorage)
			}
		}
		catch {
			completion(.failure(error))
		}
	}
	
	func loadSettings(completion: @escaping (Result<Void, Error>) -> Void) -> SettingsForSave? {
		do {
			if let userDefaults = UserDefaults(suiteName: Constants.suiteName) {
				guard let data = userDefaults.data(forKey: Constants.settingsStorage) else { return nil }
				let decoded = try JSONDecoder().decode(SettingsForSave.self, from: data)
				return decoded
			}
		}
		catch {
			completion(.failure(error))
		}
		return nil
	}
	
}

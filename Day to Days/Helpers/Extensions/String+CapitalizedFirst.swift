//
//  String+CapitalizedFirst.swift
//  Day to Days
//
//  Created by mix on 03.10.2024.
//

extension String {
    func capitalizedFirstLetter() -> String {
        guard let firstLetter = self.first else { return self }
        return firstLetter.uppercased() + self.dropFirst().lowercased()
    }
}

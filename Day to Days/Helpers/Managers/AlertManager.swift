//
//  NewAlert.swift
//  Day to Days
//
//  Created by mix on 07.09.2024.
//

import SwiftUI

@Observable
final class AlertManager {
    var errorForAlert: IdentifiableError?

    func showAlert(identifiable: IdentifiableError) -> Alert {
        Alert(
            title: Text("error".localized),
            message: Text(identifiable.id.uuidString),
            dismissButton: .default(Text("OK"))
        )
    }

    func getIdentifiebleErrorFrom(result: Result<Void, Error>) {
        switch result {
        case .success(()): break
        case .failure(let error): errorForAlert = IdentifiableError(error: error)
        }
    }

    struct IdentifiableError: Identifiable {
        let id = UUID()
        let error: Error
    }
}

//
//  ClearableTextField.swift
//  Day to Days
//
//  Created by mix on 26.09.2024.
//

import SwiftUI

struct ClearableTextField: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack {
            TextField(placeholder.localized, text: $text)
            if !text.isEmpty {
                Button {
                    withAnimation {
                        text.removeAll()
                    }
                } label: {
                    Image(systemName: "clear")
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

//
//  EventsListEmpyView.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct EventsListIsEmpyView: View {
    var onAddNew: () -> Void
    var body: some View {
        GroupBox {
            Text("event_list_empty".localized)
                .font(.title3)
            GroupBox {
                Button {
                    onAddNew()
                } label: {
                    Group {
                        Image(systemName: "plus.circle")
                        Text("add_new".localized)
                    }
                    .italic()
                    .foregroundStyle(.secondary)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

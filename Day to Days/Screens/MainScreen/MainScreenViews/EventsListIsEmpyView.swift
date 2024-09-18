//
//  EventsListEmpyView.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct EventsListIsEmpyView: View {
    var onAddNew: () -> Void
    // MARK: - View
    var body: some View {
        VStack(alignment: .center) {
            VStack {
                Text("event_list_empty".localized)
                    .font(.title2)
                    .fontWeight(.thin)
                    .foregroundStyle(.primary)
                    .padding(.bottom)
                GroupBox {
                    Button {
                        onAddNew()
                    } label: {
                        Group {
                            Image(systemName: "plus.circle")
                            Text("add_new".localized)
                        }
                        .bold()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .clipShape(Capsule())
                .shadow(color: Color.primary, radius: Сonstraints.shadowRadius)
            }
            .frame(width: Сonstraints.emptyViewFrameSize, height: Сonstraints.emptyViewFrameSize)
            .padding()
        }
        .background(Color.secondary.gradient)
        .clipShape(Circle())
        .padding(.top, Сonstraints.emptyViewPaddingToTheTop)
    }
}

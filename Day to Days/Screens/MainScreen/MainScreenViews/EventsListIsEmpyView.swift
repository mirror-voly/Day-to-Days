//
//  EventsListEmpyView.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct EventsListIsEmptyView: View {
    @Environment(MainScreenViewModel.self) var viewModel
    var onAddNew: () -> Void

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
                .shadow(color: Color.primary, radius: Constraints.shadowRadius)
            }
            .frame(width: Constraints.emptyViewFrameSize, height: Constraints.emptyViewFrameSize)
            .padding()
        }
        .background(LinearGradient(gradient: Gradient(colors: [.purple, .brown]),
                                   startPoint: .top, endPoint: .bottom)
            .rotationEffect(Angle(degrees: viewModel.isAnimating ? 0 : 180))
        )
        .clipShape(Circle())
        .shadow(color: Color.primary, radius: Constraints.shadowRadius)
        .scaleEffect(viewModel.isAnimating ? 1.1 : 1.0)
        .animation(
            Animation.easeInOut(duration: 3)
                .repeatForever(autoreverses: true),
            value: viewModel.isAnimating
        )
        .onAppear {
            viewModel.isAnimating = true
        }
        .onDisappear(perform: {
            viewModel.isAnimating = false
        })
        .padding(.top, Constraints.emptyViewPaddingToTheTop)
    }
}

//
//  EventsItemView.swift
//  Day to Days
//
//  Created by mix on 03.09.2024.
//

import SwiftUI

struct EventsItemView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(MainScreenViewModel.self) private var viewModel
    @State var isSelected = false
    let event: Event

    // MARK: - View
    var body: some View {
        let timeData = viewModel.allTimeDataFor(event: event)
        HStack {
            // MARK: - Circle
                ZStack(alignment: .center, content: {
                        Circle()
                        .fill(event.color)
                            .overlay(
                                Circle()
                                .fill(colorScheme == .light ? (isSelected ? Color.primary : .white) :
                                        (isSelected ? Color.primary : .black))
                                .frame(width: viewModel.circleHoleSize, height: viewModel.circleHoleSize))
                })
                .frame(width: viewModel.circleSize)
                .padding()
                .onChange(of: viewModel.editMode) { _, newValue in
                    if newValue != .active {
                        isSelected = false
                    }
                }
                .onChange(of: isSelected) { _, _ in
                    viewModel.toggleSelection(eventID: event.id, isSelected: isSelected)
                }
            // MARK: - Title
                Text(event.title)
                    .font(.title2)
            Spacer()
            // MARK: - Day counter
                            VStack {
                                Text(timeData["localizedTimeState"]?.capitalized ?? "")
                                    .minimumScaleFactor(viewModel.scaleFactor)
                                    .lineLimit(1)
                                Divider()
                                Text(timeData["dateNumber"] ?? "")
                                    .foregroundStyle(event.color)
                                    .bold()
                                    .font(.title3)
                                    .frame(maxWidth: .infinity)
                                    .minimumScaleFactor(viewModel.scaleFactor)
                                    .lineLimit(1)
                                Text(((timeData["timeState"] != TimeStateType.present.label ? timeData["localizetDateType"] : "") ?? ""))
                                    .italic()
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                            .frame(width: viewModel.dateFrameSize)
                            .padding()
        }
        .overlay(alignment: .center) {
            Group {
                if viewModel.editMode == .active {
                    Rectangle()
                        .fill(isSelected ? Color.primary.opacity(0.1) : Color.primary.opacity(0.01))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipShape(.rect(cornerRadius: viewModel.cornerRadius))
                        .onTapGesture {
                            viewModel.toggleSelectedState(eventID: event.id)
                            isSelected.toggle()
                        }
                }
            }
        }
    }
}

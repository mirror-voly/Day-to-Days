//
//  NotificationSettingsView.swift
//  Day to Days
//
//  Created by mix on 11.10.2024.
//

import SwiftUI

struct NotificationSettingsView: View {

    enum DayOfWeek: CaseIterable {
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
    }

    let event: Event
    @State var date = Date()
    @State var dateType: DateType = .day
    @State var dayOfWeak: DayOfWeek = .monday
    @State var popoverIsPresented = false
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("done".localized) {
                }
                .buttonStyle(.borderedProminent)
            }
            HStack(content: {
                Text("Show notification every")
                Spacer()
                Menu(String(describing: dateType).capitalized, content: {
                    ForEach(DateType.allCases, id: \.self) { type in
                        Button(String(describing: type).capitalized) {
                            dateType = type
                        }
                    }
                })
            })
            switch dateType {
            case .day:
                DatePicker("Time", selection: $date, displayedComponents: .hourAndMinute)
            case .week:
                HStack {
                    Text("Day of week")
                    Spacer()
                    Menu((String(describing: dayOfWeak).capitalized), content: {
                        ForEach(DayOfWeek.allCases, id: \.self) { type in
                            Button(String(describing: type).capitalized) {
                                dayOfWeak = type
                            }
                        }
                    })
                    DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                        .frame(width: 80)
                }
            case .month:
                DatePicker("Day of month", selection: $date)
                    .datePickerStyle(.compact)
            case .year:
                DatePicker("Day of year", selection: $date)
                    .datePickerStyle(.compact)
            }
        }
        .padding()
    }
}

#Preview {
    NotificationSettingsView(event: Event())
}

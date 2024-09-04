//
//  AddNewCounterSheet.swift
//  Day to Days
//
//  Created by mix on 04.09.2024.
//

import SwiftUI

struct AddNewCounterSheet: View {
    @State var title = ""
    @State var description = ""
    @State var date = Date()
    @State var color = Color(.white)
    @State var titleSet = false
    @State var sliderValue: Int = 0
    @State var dateType: DateCalculator.DateTypes = .day
    @Binding var sheetIsOpened: Bool
    @Binding var canDismiss: Bool
    var body: some View {
        VStack(content: {
            GroupBox("New Event") {
                GroupBox {
                    TextField(text: $title) {
                        Text("Title")
                    }
                    Divider()
                    .onChange(of: title) {
                        titleSet = title != "" ? true : false
                    }
                    .onChange(of: titleSet) {
                        canDismiss = !titleSet
                    }
                    TextField(text: $description) {
                        Text("Description")
                    }
                }
                .padding(.bottom)
                .onTapGesture(perform: {
                    hideKeyboard()
                })
                GroupBox {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    Divider()
                    ColorPicker("Color", selection: $color)
                }
                .padding(.bottom)
                GroupBox {
                    HStack(alignment: .center, content: {
                        Text("Сount")
                        Spacer()
                        Text(dateType.rawValue)
                    })
                    Slider(value: Binding(
                                    get: { Double(sliderValue) },
                                    set: { newValue in
                                        sliderValue = Int(newValue)
                                        dateType = .allCases[sliderValue]
                                    }
                    ), in: 0...Double(DateCalculator.DateTypes.allCases.count - 1), step: 1)
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                        Group {
                            Text("Day")
                            Text("Weak")
                            Text("Month")
                            Text("Year")
                        }
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                    })
                }
            }
            Spacer()
            Button(action: {
                sheetIsOpened = false
                canDismiss = true
            }, label: {
                Text("Done")
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
            })
            .disabled(!titleSet)
            .buttonStyle(BorderedProminentButtonStyle())
        })
        .padding()
    }
}

#Preview {
    AddNewCounterSheet( sheetIsOpened: .constant(true), canDismiss: .constant(true))
}

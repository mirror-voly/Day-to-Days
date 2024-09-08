//
//  AddEventFields.swift
//  Day to Days
//
//  Created by mix on 08.09.2024.
//

import SwiftUI

struct AddEventFields: View {
    @Environment(DataStore.self) private var dataStore
    @State private var popoverIsPresented = false
    @Binding var title: String
    @Binding var description: String
    @Binding var date: Date
    @Binding var color: Color

    var body: some View {
            GroupBox {
                TextField(text: $title) {
                    Text("Title")
                }
                Divider()
                TextField(text: $description) {
                    Text("Description")
                }
            }
            .padding(.bottom)
            // MARK: Date and color pickers
            GroupBox {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.compact)
                Divider()
                HStack(content: {
                    Text("Color")
                    Spacer()
                    Button(action: {
                        popoverIsPresented.toggle()
                    }, label: {
                        Text(color.description.capitalized)
                        Image(systemName: "pencil.tip.crop.circle.fill")
                    })
                    .foregroundStyle(color)
                    .popover(isPresented: $popoverIsPresented, content: {
                        VStack {
                            VStack(alignment: .trailing, content: {
                                ForEach(Constants.AllowedColor.allCases, id: \.self) { currentColor in
                                    Button(action: {
                                        color = currentColor.setColor
                                        popoverIsPresented = false
                                    }, label: {
                                        HStack(alignment: .center) {
                                            Group {
                                                Text(currentColor.rawValue)
                                                Image(systemName: "pencil.tip.crop.circle.fill")
                                            }
                                            .foregroundStyle(currentColor.setColor)
                                        }
                                    })
                                    Divider()
                                }
                            })
                            .padding()
                        }
                        .presentationCompactAdaptation(.popover)
                    })
                })
            }
            .padding(.bottom)
    }
}

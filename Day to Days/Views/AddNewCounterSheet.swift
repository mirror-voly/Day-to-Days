//
//  AddNewCounterSheet.swift
//  Day to Days
//
//  Created by mix on 04.09.2024.
//

import SwiftUI

struct AddNewCounterSheet: View {
    @State var title = ""
    @State var date = Date()
    @State var color = Color(.white)
    @State var titleSet = false
    var body: some View {
        VStack(content: {
            GroupBox("New Event") {
                GroupBox {
                    TextField(text: $title) {
                        Text("Title")
                    }
                    .padding(.bottom)
                    .onChange(of: title) {
                        titleSet = title != "" ? true : false
                    }
                    TextField(text: $title) {
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
                    ColorPicker("Color", selection: $color)
                }
                .padding(.bottom)
            }
            Spacer()
            Button(action: {
                print("done")
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
    AddNewCounterSheet()
}

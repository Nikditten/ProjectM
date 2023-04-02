//
//  DatePickerField.swift
//  ProjectM
//
//  Created by Niklas Børner on 18/03/2023.
//

import SwiftUI

struct DatePickerField: View {
    private var label: String
    private var color: Color
    @Binding var value: Date
    
    @Binding var hasDay: Bool
    @State var showDatePicker: Bool = false
    
    init(label: String, color: Color, value: Binding<Date>, hasDay: Binding<Bool>) {
        self.label = label
        self.color = color
        self._value = value
        self._hasDay = hasDay
    }
    
    // Date formatter
    let formatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $hasDay) {
                    Text(label)
                }
                .toggleStyle(CheckToggleStyle(color: color))
            
            if (hasDay) {
                TextField("", value: $value, formatter: formatter)
                    .padding(15)
                    .background(Color.textfield_background)
                    .cornerRadius(10)
                    .foregroundColor(.text)
                    .disabled(true)
                    .overlay(
                        HStack {
                            Spacer()
                            Image(systemName: showDatePicker ? "xmark.square" : "calendar")
                                .padding(.trailing, 15)
                                .foregroundColor(.text)
                        }
                    )
                    .onTapGesture {
                        withAnimation {
                            showDatePicker.toggle()
                        }
                    }
                
                if (showDatePicker) {
                    // Graphical date picker
                    DatePicker("", selection: $value, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding(.horizontal, 15)
                        .background(Color.textfield_background)
                        .cornerRadius(10)
                        .foregroundColor(.text)
                }
            }
        }
    }
}

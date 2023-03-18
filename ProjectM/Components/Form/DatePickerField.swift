//
//  DatePickerField.swift
//  ProjectM
//
//  Created by Niklas Børner on 18/03/2023.
//

import SwiftUI

struct DatePickerField: View {
    var label: String
    @Binding var value: Date
    
    @State var showDatePicker: Bool = false
    
    init(label: String, value: Binding<Date>) {
        self.label = label
        self._value = value
    }
    
    // Date formatter
    let formatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .foregroundColor(Color.text)
                .font(.footnote)
            TextField("", value: $value, formatter: formatter)
                .padding(15)
                .background(Color.textfield_background)
                .cornerRadius(10)
                .foregroundColor(.text)
                .overlay(
                    HStack {
                        Spacer()
                        Image(systemName: showDatePicker ? "xmark.square" : "calendar")
                            .padding(.trailing, 15)
                            .foregroundColor(.text)
                            .onTapGesture {
                                withAnimation {
                                    showDatePicker.toggle()
                                }
                            }
                    }
                )
            
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

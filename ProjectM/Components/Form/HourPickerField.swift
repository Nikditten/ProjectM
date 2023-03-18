//
//  TimePickerField.swift
//  ProjectM
//
//  Created by Niklas Børner on 18/03/2023.
//

import SwiftUI

struct HourPickerField: View {
    var label: String
    @Binding var value: Double
    
    init(label: String, value: Binding<Double>) {
        self.label = label
        self._value = value
    }
    
    let formatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .foregroundColor(Color.text)
                .font(.footnote)
            TextField("", value: $value, formatter: formatter)
                .keyboardType(.decimalPad)
                .padding(15)
                .background(Color.textfield_background)
                .cornerRadius(10)
                .foregroundColor(.text)
                .overlay(
                    Stepper("", value: $value, in: 0.0...100000, step: 0.25)
                        .padding(.trailing, 15)
                        .cornerRadius(10)
                        .foregroundColor(Color.primaryButton)
                )
        }
    }
}


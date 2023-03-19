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
    @Binding var showHours: Bool
    
    init(label: String, value: Binding<Double>, showHours: Binding<Bool>) {
        self.label = label
        self._value = value
        self._showHours = showHours
    }
    
    // Formatter that snaps to 15 minute intervals
    let formatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.minimum = 0
        formatter.maximum = 100000
        formatter.roundingMode = .halfUp
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $showHours) {
                    Text(label)
                }
                .toggleStyle(CheckToggleStyle())
            
            if (showHours) {
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
}


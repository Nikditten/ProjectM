//
//  MultilineTextField.swift
//  ProjectM
//
//  Created by Niklas Børner on 18/03/2023.
//

import SwiftUI

struct MultilineTextField: View {
    
    var label: String
    @Binding var value: String
    
    var keyboardType: UIKeyboardType
    var linelimit: Int

    init(label: String, value: Binding<String>, keyboardType: UIKeyboardType = .default, linelimit: Int = 1) {
        self.label = label
        self._value = value
        self.keyboardType = keyboardType
        self.linelimit = linelimit
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .foregroundColor(Color.text)
                .font(.footnote)
            TextField("", text: $value, axis: .vertical)
                .lineLimit(linelimit...linelimit * 2)
                .keyboardType(keyboardType)
                .padding(15)
                .padding(.trailing, 30)
                .background(Color.textfield_background)
                .cornerRadius(10)
                .foregroundColor(.text)
        }
    }
}

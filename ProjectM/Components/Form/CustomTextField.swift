//
//  CustomTextField.swift
//  ProjectM
//
//  Created by Niklas Børner on 18/03/2023.
//

import SwiftUI

struct CustomTextField: View {
    
    let label: String
    @Binding var value: String
    
    var keyboardType: UIKeyboardType

    init(label: String, value: Binding<String>, keyboardType: UIKeyboardType = .default) {
        self.label = label
        self._value = value
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .foregroundColor(Color.text)
                .font(.footnote)
            TextField("", text: $value)
                .keyboardType(keyboardType)
                .padding()
                .background(Color.textfield_background)
                .cornerRadius(10)
                .foregroundColor(.text)
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView()
    }
}

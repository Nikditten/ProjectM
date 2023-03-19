//
//  ColorPickerField.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import SwiftUI

struct ColorPickerField: View {
    
    let label: String
    @State var activeColor: ProjectColors = .standard
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(label)
                .foregroundColor(Color.text)
                .font(.footnote)
            
            HStack {
                
                ColorButton(color: .standard, activeColor: $activeColor)
                
                Spacer()
                
                ColorButton(color: .green, activeColor: $activeColor)
                
                Spacer()
                
                ColorButton(color: .blue, activeColor: $activeColor)
                
                Spacer()
                
                ColorButton(color: .purple, activeColor: $activeColor)
                
                Spacer()
                
                ColorButton(color: .red, activeColor: $activeColor)
                
            }
            .padding(.horizontal, 1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ColorPickerField_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerField(label: "Give the project a color")
    }
}

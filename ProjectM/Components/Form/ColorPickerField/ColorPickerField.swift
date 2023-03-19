//
//  ColorPickerField.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import SwiftUI

struct ColorPickerField: View {
    
    let label: String
    @State var activeColor: Color = Color.primaryTaskColor
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(label)
                .foregroundColor(Color.text)
                .font(.footnote)
            
            HStack (spacing: 25) {
                
                ColorButton(color: Color.primaryTaskColor, activeColor: $activeColor)
                
                ColorButton(color: Color.greenTaskColor, activeColor: $activeColor)
                
                ColorButton(color: Color.blueTaskColor, activeColor: $activeColor)
                
                ColorButton(color: Color.purpleTaskColor, activeColor: $activeColor)
                
            }
            .padding(.leading, 1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ColorPickerField_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerField(label: "Give the project a color")
    }
}

//
//  ColorPickerField.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import SwiftUI

struct ColorPickerField: View {
    
    let label: String
    @Binding var activeColor: ProjectColors
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(label)
                .foregroundColor(Color.text)
                .font(.footnote)
            
            HStack {
                
                ColorButton(color: .standard, activeColor: $activeColor)
                
                Divider()
                    .scaleEffect(x: 2, y: 1, anchor: .center)
                
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

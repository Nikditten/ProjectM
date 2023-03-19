//
//  ColorButton.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import SwiftUI

struct ColorButton: View {

    let color: Color
    @Binding var activeColor: Color
    
    var body: some View {
        Button(action: {
            withAnimation {
                activeColor = color
            }
        }) {
            Circle()
                .fill(color)
                .frame(width: 50, height: 50)
                .overlay(
                    Circle()
                        .stroke(Color.gray, lineWidth: 0.5)
                )
                .overlay(
                    Group {
                        if (color == activeColor) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                        }
                    }
                )
        }
    }
}

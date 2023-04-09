//
//  SubmitButton.swift
//  ProjectM
//
//  Created by Niklas Børner on 18/03/2023.
//

import SwiftUI

struct SubmitButton: View {
    
    let label: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.title)
                .foregroundColor(Color.white)
                .padding(15)
                .frame(width: UIScreen.screenWidth - 32.5)
                .background(color)
                .cornerRadius(10)
        }
    }
}

//
//  SubmitButton.swift
//  ProjectM
//
//  Created by Niklas Børner on 18/03/2023.
//

import SwiftUI

struct SubmitButton: View {
    
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.title)
                .foregroundColor(Color.white)
                .padding()
                .background(Color.primaryButton)
                .cornerRadius(15.0)
        }
    }
}

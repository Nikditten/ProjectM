//
//  SortingButton.swift
//  ProjectM
//
//  Created by Niklas Børner on 09/04/2023.
//

import SwiftUI

struct SortingButton: View {
    
    let value: String
    let active: Bool
    let onClicked: Void
    
    var body: some View {
        Button(action: {onClicked}, label: {
            Text(value)
            if (active) {
                Image(systemName: "checkmark")
            }
        })
    }
}

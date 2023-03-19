//
//  ProjectColors.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import SwiftUI


enum ProjectColors: String, CaseIterable {
    case standard = "standard"
    case green = "green"
    case blue = "blue"
    case purple = "purple"
    case red = "red"
    

    func toColor() -> Color {
        switch self {
        case .standard:
            return Color.primaryTaskColor
            
        case .green:
            return Color.greenTaskColor
            
        case .blue:
            return Color.blueTaskColor
            
        case .purple:
            return Color.purpleTaskColor
            
        case .red:
            return Color.redTaskColor
        
        }
    }

    func toString() -> String {
        switch self {
        case .standard:
            return "Standard"
            
        case .green:
            return "Green"
            
        case .blue:
            return "Blue"
            
        case .purple:
            return "Purple"
            
        case .red:
            return "Red"
        
        }
    }
}

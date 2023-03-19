//
//  ProjectColors.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import Foundation


enum ProjectColors: String, CaseIterable {
    case standard = "standard"
    case green = "green"
    case blue = "blue"
    case purple = "pruple"
    

    func getColor() -> Color {
        switch self {
        case .standard:
            return Color.primaryTaskColor
            
        case .green:
            return Color.greenTaskColor
            
        case .blue:
            return Color.blueTaskColor
            
        case .purple:
            return Color.purpleTaskColor
        
        }
    }
}

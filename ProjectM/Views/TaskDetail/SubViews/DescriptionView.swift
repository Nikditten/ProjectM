//
//  DescriptionView.swift
//  ProjectM
//
//  Created by Niklas Børner on 22/04/2023.
//

import SwiftUI

struct DescriptionView: View {
    
    var description: String
    var color: Color
    
    init(description: String, color: Color) {
        self.description = description
        self.color = color
    }
    
    var body: some View {
        Text("Description")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(Color.text)
            
        
        Spacer().height(20)
        
        ExpandableText(description, color: color)
    }
}

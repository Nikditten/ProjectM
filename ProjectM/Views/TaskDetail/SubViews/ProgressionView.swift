//
//  ProgressionView.swift
//  ProjectM
//
//  Created by Niklas Børner on 22/04/2023.
//

import SwiftUI

struct ProgressionView: View {
    
    var color: Color
    var markAsCompleted: Bool
    var toggleState: () -> Void
    var progression: Double
    
    init (color: ProjectColors, markAsCompleted: Bool, progression: Double, _ toggleState: @escaping () -> Void) {
        self.color = color.toColor()
        self.markAsCompleted = markAsCompleted
        self.toggleState = toggleState
        self.progression = progression
    }
    
    var body: some View {
        
        Text("Progression")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(Color.text)
        
        Spacer().height(20)
        
        HStack (alignment: .center) {
            
            Text(markAsCompleted ? "Completed" :  "Ongoing")
                .foregroundColor(Color.text)
            
            Spacer()
            
            Button {
                withAnimation {
                    toggleState()
                }
            } label: {
                Image(systemName: markAsCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(color)
                    .accessibility(label: Text(markAsCompleted ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .font(.headline)
        
        Spacer().height(10)
        
        ProgressView(value: markAsCompleted ? 1 : progression, total: 1)
            .tint(color)
            .scaleEffect(x: 1, y: 2, anchor: .center) 
    }
}

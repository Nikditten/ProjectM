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
    var hasDeadline: Bool
    var hasEstimation: Bool
    var deadline: Date
    var estimation: Double
    
    init (task: Task, markAsCompleted: Bool, progression: Double, _ toggleState: @escaping () -> Void) {
        self.color = task.color.toColor()
        self.markAsCompleted = markAsCompleted
        self.toggleState = toggleState
        self.progression = progression
        self.hasDeadline = task.hasDeadline
        self.hasEstimation = task.hasEstimation
        self.deadline = task.deadline ?? Date()
        self.estimation = task.estimation ?? 0.0
    }
    
    var body: some View {
        
        Text("Progression")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(Color.text)
        
        Spacer().height(20)
        
        HStack (alignment: .center, spacing: 5) {
            HStack {
                Image(systemName: "calendar")
                Text(hasDeadline ? deadline.formatAsDate() : "No deadline")
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "alarm")
                Text(hasEstimation ? Formatter.hoursBrief.string(from: estimation * 60 * 60)! : "No estimation")
            }
        }
        .foregroundColor(Color.taskcardText.opacity(0.75))
        .font(.headline)
        .padding()
        .background(Color.taskDetailCardBackground)
        .cornerRadius(10)
        
        Spacer().height(10)
        
        VStack {
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
            .padding([.top, .horizontal])
            
            Spacer().height(10)
            
            ProgressView(value: markAsCompleted ? 1 : progression, total: 1)
                .tint(color)
                .scaleEffect(x: 1, y: 2, anchor: .center) 
        }
        .background(Color.taskDetailCardBackground)
        .cornerRadius(10)
    }
}

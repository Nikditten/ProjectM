//
//  GeneralInformationView.swift
//  ProjectM
//
//  Created by Niklas Børner on 22/04/2023.
//

import SwiftUI

struct GeneralInformationView: View {
    
    var title: String
    var description: String
    var hasDeadline: Bool
    var deadline: Date
    var hasEstimation: Bool
    var estimation: Double
    var color: Color
    
    init (task: Task) {
        self.title = task.title
        self.hasDeadline = task.hasDeadline
        self.deadline = task.deadline ?? Date()
        self.hasEstimation = task.hasEstimation
        self.estimation = task.estimation ?? 0.0
        self.color = task.color.toColor()
        
        if (task.description?.count ?? 0 > 0) {
            self.description = task.description!
        } else {
            self.description = "No description"
        }
    }
    
    var body: some View {
        
        
        Text(title)
            .foregroundColor(Color.taskcardText)
            .font(.largeTitle)
            .fontWeight(.bold)
            .minimumScaleFactor(0.1)
            .truncationMode(.tail)
        
        Spacer().height(15)
        
        ExpandableText(description, color: color)
        
    }
}

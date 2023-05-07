//
//  GeneralInformationView.swift
//  ProjectM
//
//  Created by Niklas Børner on 22/04/2023.
//

import SwiftUI

struct GeneralInformationView: View {
    
    var title: String
    var description: String?
    var hasDeadline: Bool
    var deadline: Date
    var hasEstimation: Bool
    var estimation: Double
    var color: Color
    
    init (project: Project) {
        self.title = project.title
        self.hasDeadline = project.hasDeadline
        self.deadline = project.deadline ?? Date()
        self.hasEstimation = project.hasEstimation
        self.estimation = project.estimation ?? 0.0
        self.color = project.color.toColor()
        
        if (project.description?.count ?? 0 > 0) {
            self.description = project.description
        }
    }
    
    var body: some View {
        
        Text(title)
            .foregroundColor(Color.taskcardText)
            .font(.largeTitle)
            .fontWeight(.bold)
            .minimumScaleFactor(0.1)
            .truncationMode(.tail)
        
        if (description != nil) {
            Spacer().height(15)
            ExpandableText(description!, color: color)
        }
        
    }
}

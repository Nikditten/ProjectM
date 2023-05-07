//
//  TaskCard.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import SwiftUI

struct ProjectCard: View {
    
    let project: Project
    @ObservedObject var dataSource: DataSource
    
    init(project: Project, dataSource: DataSource = DataSource.shared) {
        self.project = project
        self.dataSource = dataSource
    }
    
    var progression: Double {
        if (project.completed) {
            return 1
        } else if (project.hasTasks()) {
            var completedTasks: Double = 0
            let tasks: [Task] = dataSource.tasks.values.filter { $0.projectId == project.id }
            for task in tasks {
                if (task.completed()) {
                    completedTasks += 1
                }
            }
            return completedTasks / Double(tasks.count)
        } else {
            return 0
        }
    }
    
    var body: some View {
        HStack {
            
            HStack(alignment: .center) {
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(project.title)
                        .foregroundColor(Color.taskcardText)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .truncationMode(.tail)
                        .lineLimit(1)
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text(project.hasDeadline ? project.deadline!.formatAsDate() : "No deadline")
                    }
                    .foregroundColor(Color.taskcardText.opacity(0.75))
                    .font(.system(size: 10))
                    
                    HStack {
                        Image(systemName: "alarm")
                        Text(
                            project.hasEstimation ? Formatter.hoursBrief.string(from: project.estimation! * 60 * 60)! : "No estimation"
                        )
                    }
                    .foregroundColor(Color.taskcardText.opacity(0.75))
                    .font(.system(size: 10))
                    
                    Text(project.timestamp.formatAsDate())
                        .foregroundColor(Color.taskcardText.opacity(0.75))
                        .font(.system(size: 8))
                        .padding(.top, 4)
                    
                }
                .padding(.trailing)
                Spacer()
                CircularProgressBar(color: project.color.toColor(), progress: progression)
            }
            .padding(15)
            
            Rectangle()
                .frame(width: 20)
                .foregroundColor(project.color.toColor())
        }
        .background(Color.textfield_background)
        .cornerRadius(10)
        
    }
}

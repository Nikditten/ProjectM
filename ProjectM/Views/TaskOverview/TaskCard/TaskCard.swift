//
//  TaskCard.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import SwiftUI

struct TaskCard: View {
    
    let task: Task
    @ObservedObject var dataSource: DataSource
    
    init(task: Task, dataSource: DataSource = DataSource.shared) {
        self.task = task
        self.dataSource = dataSource
    }
    
    var progression: Double {
        if (task.completed) {
            return 1
        } else if (task.hasSubTasks()) {
            var completedSubTasks: Double = 0
            let subtasks: [SubTask] = dataSource.subTasks.values.filter { $0.taskId == task.id }
            for subtask in subtasks {
                if (subtask.completed()) {
                    completedSubTasks += 1
                }
            }
            return completedSubTasks / Double(subtasks.count)
        } else {
            return 0
        }
    }
    
    var body: some View {
        HStack {
            
            HStack(alignment: .center) {
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(task.title)
                        .foregroundColor(Color.taskcardText)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .truncationMode(.tail)
                        .lineLimit(1)
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text(task.hasDeadline ? task.deadline!.formatAsDate() : "No deadline")
                    }
                    .foregroundColor(Color.taskcardText.opacity(0.75))
                    .font(.system(size: 10))
                    
                    HStack {
                        Image(systemName: "alarm")
                        Text(
                            task.hasEstimation ? Formatter.hoursBrief.string(from: task.estimation! * 60 * 60)! : "No estimation"
                        )
                    }
                    .foregroundColor(Color.taskcardText.opacity(0.75))
                    .font(.system(size: 10))
                    
                    Text(task.timestamp.formatAsDate())
                        .foregroundColor(Color.taskcardText.opacity(0.75))
                        .font(.system(size: 8))
                        .padding(.top, 4)
                    
                }
                .padding(.trailing)
                Spacer()
                CircularProgressBar(color: task.color.toColor(), progress: progression)
            }
            .padding(15)
            
            Rectangle()
                .frame(width: 20)
                .foregroundColor(task.color.toColor())
        }
        .background(Color.textfield_background)
        .cornerRadius(10)
        
    }
}

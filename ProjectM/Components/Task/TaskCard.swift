//
//  TaskCard.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import SwiftUI

struct TaskCard: View {
    
    let task: Task
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 5) {
                Text(task.name ?? "Task")
                    .foregroundColor(Color.white)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                
                if (task.estimation != 0.0) {
                    HStack {
                        Image(systemName: "alarm")
                        Text(String(task.estimation) + " hours")
                    }
                    .foregroundColor(Color.white.opacity(0.75))
                    .font(.system(size: 15))
                }
                
                if (task.deadline != nil) {
                    HStack {
                        Image(systemName: "calendar")
                        Text(task.deadline!.formatAsDate())
                    }
                    .foregroundColor(Color.white.opacity(0.75))
                    .font(.system(size: 15))
                }
                
                if ((task.deadline == nil || task.estimation == 0.0) && task.note != nil) {
                    HStack {
                        Image(systemName: "text.alignleft")
                        Text(task.note!)
                            .truncationMode(.tail)
                            .lineLimit(task.deadline == nil && task.estimation == 0.0 ? 2 : 1)
                    }
                        .foregroundColor(Color.white.opacity(0.75))
                        .font(.system(size: 15))
                }
                
            }
            Spacer()
            CircularProgressBar(progress: 0.23)
        }
        .padding(10)
        .background(ProjectColors(rawValue: task.color!)!.toColor())
        .cornerRadius(10)
      }
  }

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
                    .foregroundColor(Color.taskcardText)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .truncationMode(.tail)
                    .lineLimit(1)
                
                HStack {
                    Image(systemName: "alarm")
                    Text(
                        task.estimation != 0.0 ? Formatter.hoursBrief.string(from: task.estimation * 60 * 60)! : "No estimation"
                    )
                }
                .foregroundColor(Color.taskcardText.opacity(0.75))
                .font(.system(size: 10))
                
                HStack {
                    Image(systemName: "calendar")
                    Text(task.deadline != nil ? task.deadline!.formatAsDate() : "No deadline")
                }
                .foregroundColor(Color.taskcardText.opacity(0.75))
                .font(.system(size: 10))
                
                Text(task.timestamp!.formatAsDate())
                    .foregroundColor(Color.taskcardText.opacity(0.75))
                    .font(.system(size: 8))
                    .padding(.top, 4)
                
            }
            .padding(.trailing)
            Spacer()
            CircularProgressBar(progress: 0.75)
        }
        .padding(15)
        .background(ProjectColors(rawValue: task.color!)!.toColor())
        .cornerRadius(10)
      }
  }

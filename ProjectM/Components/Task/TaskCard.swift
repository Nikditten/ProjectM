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
          HStack {
              Button {
                  withAnimation {
                      if (task.state == 0) {
                          task.state = 1
                      } else {
                          task.state = 0
                      }
                  }
              } label: {
                  Image(systemName: task.state == 1 ? "checkmark.circle.fill" : "circle")
                      .foregroundColor(task.state == 1 ? Color.onToggle : Color.offToggle)
                      .accessibility(label: Text(task.state == 1 ? "Checked" : "Unchecked"))
                      .imageScale(.large)
              }
              .font(.footnote)
              .buttonStyle(PlainButtonStyle())
              .padding(.trailing, 20)
              
              HStack(alignment: .center) {
                  VStack(alignment: .leading, spacing: 5) {
                      Text(task.name ?? "Task")
                          .foregroundColor(Color.text)
                          .font(.system(size: 15))
                          .fontWeight(.bold)
                      
                      HStack {
                          Image(systemName: "alarm")
                          Text(String(task.estimation) + " hours")
                      }
                      .foregroundColor(Color.text.opacity(0.5))
                      .font(.system(size: 15))
                      
                      if (task.deadline != nil) {
                          HStack {
                              Image(systemName: "calendar")
                              Text(task.deadline!.formatAsDate())
                          }
                          .foregroundColor(Color.text.opacity(0.5))
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
  }

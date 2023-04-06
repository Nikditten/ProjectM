//
//  SubTaskCard.swift
//  ProjectM
//
//  Created by Niklas Børner on 27/03/2023.
//

import SwiftUI

struct SubTaskCard: View {
    
    var subTask: SubTask
    var color: ProjectColors = ProjectColors.standard
    
    init(subtaskId: UUID, color: ProjectColors, dataSource: DataSource = DataSource.shared) {
        self.subTask = dataSource.getSubTask(with: subtaskId)!
        self.color = color
    }
    
    @State var showMore = false
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    withAnimation {
                        print("HHHH")
                    }
                } label: {
                    Image(systemName: subTask.state == TaskState.Completed ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(color.toColor())
                        .accessibility(label: Text(subTask.state == TaskState.Completed ? "Checked" : "Unchecked"))
                        .imageScale(.large)
                }
                .font(.headline)
                .frame(alignment: .topLeading)
                .buttonStyle(PlainButtonStyle())
                
                Text(subTask.title)
                    .foregroundColor(Color.subTaskCardText)
                    .minimumScaleFactor(0.2)
                    .truncationMode(.tail)
                
                Spacer()
                
                Button {
                    withAnimation {
                        showMore.toggle()
                    }
                } label: {
                    Image(systemName: showMore ? "chevron.up" : "chevron.down")
                        .foregroundColor(color.toColor())
                        .accessibility(label: Text(subTask.state == TaskState.Completed ? "Show More" : "Show less"))
                        .imageScale(.large)
                }
                .font(.subheadline)
                .frame(alignment: .topLeading)
                .buttonStyle(PlainButtonStyle())
            }
            
            if (showMore) {
                Text(subTask.description)
                    .font(.subheadline)
                    .foregroundColor(subTask.description.count > 0 ? Color.text : Color.text.opacity(0.25))
                    .lineLimit(2...)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 34)
                
                HStack (spacing: 20) {
                    Spacer()
                    
                    Button {
                        withAnimation {
                            showMore.toggle()
                        }
                    } label: {
                        Image(systemName: "highlighter")
                            .foregroundColor(.subTaskCardText)
                            .accessibility(label: Text("Edit"))
                            .imageScale(.large)
                    }
                    .font(.subheadline)
                    .frame(alignment: .topLeading)
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.subTaskCardBackground)
        .cornerRadius(10)
      }
  }


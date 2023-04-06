//
//  SubTaskCard.swift
//  ProjectM
//
//  Created by Niklas Børner on 27/03/2023.
//

import SwiftUI

struct SubTaskCard: View {
    
    let projectColor: Color
    let title: String
    let description: String
    
    @Binding var completed: Bool
    
    init(projectColor: Color, title: String, description: String, completed: Binding<Bool>, dataSource: DataSource = DataSource.shared) {
        self.projectColor = projectColor
        self.title = title
        self.description = description
        self._completed = completed
    }
    
    @State var showMore = false
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    withAnimation {
                        completed.toggle()
                    }
                } label: {
                    Image(systemName: completed ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(projectColor)
                        .accessibility(label: Text(completed ? "Checked" : "Unchecked"))
                        .imageScale(.large)
                }
                .font(.headline)
                .frame(alignment: .topLeading)
                .buttonStyle(PlainButtonStyle())
                
                Text(title)
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
                        .foregroundColor(projectColor)
                        .accessibility(label: Text(completed ? "Show More" : "Show less"))
                        .imageScale(.large)
                }
                .font(.subheadline)
                .frame(alignment: .topLeading)
                .buttonStyle(PlainButtonStyle())
            }
            
            if (showMore) {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(description.count > 0 ? Color.text : Color.text.opacity(0.25))
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


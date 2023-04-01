//
//  SubTaskCard.swift
//  ProjectM
//
//  Created by Niklas Børner on 27/03/2023.
//

import SwiftUI

struct SubTaskCard: View {
    
    let projectColor: Color
    let _subtask: SubTask
    
    @State var completed = false
    
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    completed.toggle()
                }
            } label: {
                Image(systemName: completed ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(completed ? projectColor : Color.subTaskCheckbox)
                    .accessibility(label: Text(completed ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
            .font(.footnote)
            .frame(alignment: .topLeading)
            .buttonStyle(PlainButtonStyle())
            
            Text(_subtask.name!)
                .foregroundColor(Color.subTaskCardText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.subTaskCardBackground)
        .cornerRadius(10)
      }
  }


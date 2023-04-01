//
//  SubTaskCard.swift
//  ProjectM
//
//  Created by Niklas Børner on 27/03/2023.
//

import SwiftUI

struct SubTaskCard: View {
    
    let _subtask: SubTask
    
    let projectColor: Color
    
    @State var completed = false
    
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    completed.toggle()
                }
            } label: {
                Image(systemName: completed ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(completed ? Color.white : Color.white)
                    .accessibility(label: Text(completed ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
            .font(.footnote)
            .frame(alignment: .topLeading)
            .buttonStyle(PlainButtonStyle())
            
            Text(_subtask.name!)
                .foregroundColor(Color.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(projectColor)
        .cornerRadius(10)
      }
  }

